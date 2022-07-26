<#
  .SYNOPSIS
  Detects any new versions of modules for https://msshells.net
  
  .DESCRIPTION
  Detects any new versions of modules for https://msshells.net
  Should be run via scheduled GitHub Actions
  Version: 0.2

  .NOTES
  Author: Robert Dyjas https://github.com/robdy

  Workflow:
  - Before running, make sure to checkout the repository 
  so the data can be pulled from local file
  - Get current data from Markdown files
  - Update checked file so that PR can be opened

  Known issues:
  - Not working for modules outside gallery, i.e. Microsoft.SharePoint.MigrationTool

  .EXAMPLE
  checker.ps1
#>

# ================
#region Variables
# ================
$dataFolderPath = "./_ps_modules"
$excludedModules = @('Microsoft.SharePoint.MigrationTool')

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
  # Convert files from YAML
  $moduleDataObj = Get-ChildItem -Path $dataFolderPath | ForEach-Object {
    @{
      FileName = $PSItem.Name
      Content = ConvertFrom-Yaml -Yaml (
          Get-Content -Path $PSItem -Raw
        ).replace("---`n", "").trim()
    }
  }
  
  $modulesToBeChecked = $moduleDataObj.Content.Name |
    Where-Object { $_ -notin $excludedModules } |
    Select-Object -Unique
  foreach ($moduleName in $modulesToBeChecked) {
    <#
    $moduleName = $modulesToBeChecked[0]
    #>
    $allModuleVersions = $null
    $latestVersion = $null
    $latestPreview = $null
    $latestVersionNumber = $null
    $latestPreviewNumber = $null

    $moduleEntry = $moduleDataObj.Content | Where-Object name -eq $moduleName
    $allModuleVersions = Find-Module $moduleName -AllVersions -AllowPrerelease
    $latestVersion = $allModuleVersions | Where-Object {$_.AdditionalMetadata.IsPrerelease -ne 'true'} |
          Sort-Object {[System.Version]($_.Version)} |
                Select-Object -Last 1
    $latestPreview = $allModuleVersions | Where-Object {$_.AdditionalMetadata.isPrerelease -eq 'true'} |
          Sort-Object {[System.Version]($_.Version -replace("-preview|-beta|-alpha |-nightly",""))} |
          Select-Object -Last 1
    $latestVersionNumber = $latestVersion.Version
    $latestPreviewNumber = $latestPreview.Version
  
    if ($moduleEntry.stableVersion -ne $latestVersionNumber) {
      $changesDetected += @{
        "Module" = $moduleName
        "Type" = "Release"
        "Version" = $latestVersionNumber
      }
      Write-Host "New version of $moduleName released: $latestVersionNumber"
    } else {
      Write-Verbose "No new version of $moduleName found"
    }
    if (
        $moduleEntry.previewVersion -match '(\d+\.){2,3}\d+' -and
        $moduleEntry.previewVersion -ne $latestPreviewNumber
      ) {
        $changesDetected += @{
          "Module" = $moduleName
          "Type" = "Prerelease"
          "Version" = $latestPreviewNumber
        }
      Write-Host "New prerelease version of $moduleName found: $latestPreviewNumber"
    } else {
      Write-Verbose "No new prerelease version of $moduleName found"
    }
  }
  
  if (-not $changesDetected) {
    Write-Host 'No updates to modules detected'
    return
  }
  
  foreach ($change in $changesDetected) {
    <#
    $change = $changesDetected[0]
    #>
    $changedModuleFileNames = @((
      $moduleDataObj | Where-Object {$_.Content.Name -eq $change.Module}
      ).FileName)
    foreach ($changedModuleFileName in $changedModuleFileNames) {
      $changedModuleFilePath = (Join-Path $dataFolderPath $changedModuleFileName)
      if ($change.Type -eq 'Release') {
        $replacePattern = '^(stableVersion): (.*$)'
      }
      if ($change.Type -eq 'Prerelease') {
        $replacePattern = '^(previewVersion): (.*$)'
      }
      $oldContent = Get-Content -Path $changedModuleFilePath
      $newContent = $oldcontent -replace ($replacePattern, "`$1: $($change.Version)")
      $newContent | Out-File $changedModuleFilePath
    }
  }

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
