<#
  .SYNOPSIS
  Detects any new versions of modules for https://msshells.net
  
  .DESCRIPTION
  Detects any new versions of modules for https://msshells.net
  Should be run via scheduled GitHub Actions
  Version: 0.1

  .NOTES
  Author: Robert Dyjas https://github.com/robdy

  Workflow:
  - Before running, make sure to checkout the repository 
  so the data can be pulled from local file
  - Get current data from Markdown file
  - Update checked file so that PR can be opened

  Known issues:
  - Not working for modules outside gallery, i.e. Microsoft.SharePoint.MigrationTool

  .EXAMPLE
  checker.ps1
#>

# ================
#region Variables
# ================
$indexFilePath = 'index.markdown'
$modulesToBeChecked = @(
  'MicrosoftTeams',
  'ExchangeOnlineManagement',
  'Microsoft.Online.SharePoint.PowerShell',
  'AzureAD',
  'AzureADPreview',
  'WhiteboardAdmin',
  # 'Microsoft.SharePoint.MigrationTool',
  'MicrosoftPowerBIMgmt',
  'Microsoft.PowerApps.Administration.PowerShell',
  'Microsoft.PowerApps.PowerShell',
  'MSCommerce'
)
$batchSize = 40
$findPackagesEndpointUrl = 'https://www.powershellgallery.com/api/v2/FindPackagesById()'

# Regexes
$moduleRegex = '^\|(?:[^\|]*)\| *\[(?:[\w .]*)\]\(https\:\/\/www\.powershellgallery\.com\/packages\/(\w.*)\/?\) *\|([^\|]*)\|[^\|]*\|([^\|]*)\|[^\|]*'
$skippedLinesRegex = '^\|(?:(?: *To Administer)|(?:-+))'

$changesDetected = @()

# ================
#endregion Variables
# ================

# ================
#region Processing
# ================
try {
  $ErrorActionPreference = 'Stop'
  $startTime = Get-Date
  Write-Host "Starting script at $startTime"
  
  # Get current data
  if ($env:GITHUB_ACTIONS) {
    Set-Location $env:GITHUB_WORKSPACE
  }
  $mdFileContent = Get-Content $indexFilePath
  
  # Filter out unnecessary lines
  $moduleRows = $mdFileContent.Split("`n") | Where-Object {
    $_ -match $moduleRegex -and
    $_ -notmatch $skippedLinesRegex
  }
  
  # Extract version from applicable lines
  $moduleData = foreach ($moduleRow in $moduleRows) {
    <#
    $moduleRow = $moduleRows[0]
    #>
    $Matches = $null
    if ($moduleRow -match $moduleRegex) {
      @{
        "ModuleName" = $Matches[1].Trim() -replace('\/$','')
        "Version" = $Matches[2].Trim()
        "PrereleaseVersion" = $Matches[3].Trim()
      }
    }
  }
  
  foreach ($moduleName in $modulesToBeChecked) {
    <#
    $moduleName = $modulesToBeChecked[0]
    #>
    $skip = 0
    $latestVersion = $null
    $latestPreview = $null
    $moduleEntry = $moduleData | Where-Object Modulename -eq $moduleName
    do {
      $res = Invoke-RestMethod -Method Get -Uri "$($findPackagesEndpointUrl)?id='$moduleName'&`$skip=$skip&`$top=$batchSize"
      if ($res) {
        $latestVersion = $res | Where-Object {$_.properties.IsLatestVersion.'#text' -eq 'true'}
        $latestPreview = $res | Where-Object {$_.properties.isPrerelease.'#text' -eq 'true'} |
          Sort-Object {[System.Version]($_.properties.Version -replace("-preview|-beta|-alpha",""))} |
          Select-Object -Last 1
      }
      $skip += $batchSize
    } until ($latestVersion -or $skip -eq '1000')
  
    if ($moduleEntry.Version -ne $latestVersion.properties.Version) {
      $changesDetected += @{
        "Module" = $moduleName
        "Type" = "Release"
        "Version" = $latestVersion.properties.Version
      }
      Write-Host "New version of $moduleName released: $($latestVersion.properties.Version)"
    } else {
      Write-Verbose "No new version of $moduleName found"
    }
    if (
        $moduleEntryPrereleaseVersion -match '(\d+\.){2,3}\d+' -and
        $moduleEntry.PrereleaseVersion -ne $latestPreview.properties.Version
      ) {
        $changesDetected += @{
          "Module" = $moduleName
          "Type" = "Prerelease"
          "Version" = $latestPreview.properties.Version
        }
      Write-Host "New prerelease version of $moduleName found: $($latestPreview.properties.Version)"
    } else {
      Write-Verbose "No new prerelease version of $moduleName found"
    }
  }
  
  if (-not $changesDetected) {
    Write-Host 'No updates to modules detected'
    return
  }
  
  $currentContent = Get-Content $indexFilePath
  
  foreach ($change in $changesDetected) {
    <#
    $change = $changesDetected[0]
    #>
    $currentContent = $currentContent | ForEach-Object {
      if ($_ -match "https\:\/\/www\.powershellgallery\.com\/packages\/$($change.Module)") {
        if ($_ -match '\| *((?:\d+\.){2,}\d+(?:-preview)?)\d* *\|') {
          $version = $Matches[1]
          "$($_ -replace ($version, $change.Version))"
        }
      } else {
        $_
      }
    }
  }

  $currentContent | Out-File $indexFilePath
  Write-Host 'Finished updating data'

  # Output value to be used in commit message
  $changedCount = @($changesDetected.module).count
  if ($changedCount -gt 1) {
    $changedText = "$changedCount modules"
    $module = 'modules'
    $version = 'versions'
  } else {
    $changedText = $changesDetected.module
    $module = 'module'
    $version = 'version'
  }

  echo "::set-output name=changed::$changedText"
  echo "::set-output name=module::$module"
  echo "::set-output name=version::$version" 

  
} catch {
  $err = $_
  Write-Host "ERROR at $($err.ScriptStackTrace)"
  Write-Host $err.Exception.Message
} finally {
  $endTime = Get-Date
  $processedInSeconds = [math]::round(($endTime - $startTime).TotalSeconds)
  Write-Host "Script finished in $processedInSeconds seconds"
  # Uncomment for debugging
  # Write-Host $currentContent
}

# ================
#endregion Processing
# ================
