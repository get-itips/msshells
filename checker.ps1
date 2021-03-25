Set-Location $env:GITHUB_WORKSPACE
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
  'Microsoft.PowerApps.PowerShell'
)
$moduleRegex = '^\|(?:[^\|]*)\| *\[(?:[\w .]*)\]\(https\:\/\/www\.powershellgallery\.com\/packages\/(\w.*)\/?\) *\|([^\|]*)\|[^\|]*\|([^\|]*)\|[^\|]*'
$changesDetected = @()

$mdFileContent = Get-Content $indexFilePath

$moduleRows = foreach ($fileRow in $mdFileContent.Split("`n")) {
  # Skip non-modules lines
  if ($fileRow -notmatch $moduleRegex) {
    continue
  }
  # Skip top rows
  if ($fileRow -match '^\|(?:(?: *To Administer)|(?:-+))') {
    continue
  }
  $fileRow
}
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
  $moduleEntry = $moduleData | Where-Object Modulename -eq $moduleName
  do {
    $res = Invoke-RestMethod -Method Get -Uri "https://www.powershellgallery.com/api/v2/FindPackagesById()?id='$moduleName'&`$skip=$skip&`$top=40"
    if ($res) {
      $latestVersion = $res | Where-Object {$_.properties.IsLatestVersion.'#text' -eq 'true'}
      $latestPreview = $res | Where-Object {$_.properties.isPrerelease.'#text' -eq 'true'} |
        Sort-Object {[System.Version]($_.properties.Version -replace("-preview|-beta|-alpha",""))} |
        Select-Object -Last 1
    }
    $skip += 40
  } until ($latestVersion -or $skip -eq '1000')

  if ($moduleEntry.Version -ne $latestVersion.properties.Version) {
    $changesDetected += @{
      "Module" = $moduleName
      "Type" = "Release"
      "Version" = $latestVersion.properties.Version
    }
    # "New version of $moduleName released: $($latestVersion.properties.Version)"
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
  
    # $changesDetected += "New prerelease version of $moduleName found: $($latestPreview.properties.Version)"
  } else {
    Write-Verbose "No new prerelease version of $moduleName found"
  }
}

if (-not $changesDetected) {
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
