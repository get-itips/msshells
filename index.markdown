---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---


| To Administer   |   Module Name  | Stable Version | How To Install                | Preview Version | How To Install                                                                 |
|-----------------|:--------------:|---------------:|-------------------------------|-----------------|--------------------------------------------------------------------------------|
| Microsoft Teams | [MicrosoftTeams](https://www.powershellgallery.com/packages/MicrosoftTeams) |          2.3.0 | Install-Module MicrosoftTeams | 2.2.0-preview  | Install-Module MicrosoftTeams -RequiredVersion 2.2.0-preview -AllowPrerelease |
| Exchange Online | [ExchangeOnlineManagement](https://www.powershellgallery.com/packages/ExchangeOnlineManagement)  |2.0.4|Install-Module -Name ExchangeOnlineManagement|2.0.5-Preview1|Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5-Preview1 -AllowPrerelease|
| Security & Compliance        |[ExchangeOnlineManagement](https://www.powershellgallery.com/packages/ExchangeOnlineManagement)                |2.0.4                |Install-Module -Name ExchangeOnlineManagement|2.0.5-Preview2|Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5-Preview2 -AllowPrerelease|
|SharePoint Online|[Microsoft.Online.SharePoint.PowerShell](https://www.powershellgallery.com/packages/Microsoft.Online.SharePoint.PowerShell)|16.0.21213.12000|Install-Module -Name Microsoft.Online.SharePoint.PowerShell|N/A|N/A|
|Azure AD|[AzureAD](https://www.powershellgallery.com/packages/AzureAD)|2.0.2.130|Install-Module -Name AzureAD|See next row|N/A|
|Azure AD|[AzureADPreview](https://www.powershellgallery.com/packages/AzureADPreview/)|2.0.2.134|Install-Module -Name AzureADPreview|N/A|N/A|
|Whiteboard|[WhiteboardAdmin](https://www.powershellgallery.com/packages/WhiteboardAdmin)|1.2.0|Install-Module -Name WhiteboardAdmin|N/A|N/A|
|SharePoint Migration Tool|[Microsoft.SharePoint.MigrationTool](https://docs.microsoft.com/en-us/sharepointmigration/new-and-improved-features-in-the-sharepoint-migration-tool)|3.4.120.7|Tricky, see [here](https://aka.ms/spmt-ga-page) and [here](https://docs.microsoft.com/sharepointmigration/overview-spmt-ps-cmdlets#before-you-begin)|3.4.121.5|Tricky, see [here](https://spmtreleasescus.blob.core.windows.net/betainstall/default.htm) and [here](https://docs.microsoft.com/sharepointmigration/overview-spmt-ps-cmdlets#before-you-begin)|
|Rollup module for Power BI Cmdlets|[MicrosoftPowerBIMgmt](https://www.powershellgallery.com/packages/MicrosoftPowerBIMgmt)|1.0.974|Install-Module -Name MicrosoftPowerBIMgmt|N/A|N/A|
|PowerApps (Administrator)|[Microsoft.PowerApps.Administration.PowerShell](https://www.powershellgallery.com/packages/Microsoft.PowerApps.Administration.PowerShell)|2.0.123|Install-Module -Name Microsoft.PowerApps.Administration.PowerShell|N/A|N/A|
|PowerApps (Maker)|[Microsoft.PowerApps.PowerShell](https://www.powershellgallery.com/packages/Microsoft.PowerApps.PowerShell/)|1.0.20|Install-Module -Name Microsoft.PowerApps.PowerShell|N/A|N/A|
|MS Commerce|[MSCommerce](https://www.powershellgallery.com/packages/MSCommerce)|1.6|Install-Module -Name MSCommerce|N/A|N/A|

Do you think a module is missing or has incorrect information? Please, let me know, either creating an [issue](https://github.com/get-itips/msshells/issues/new) or a [pull request](https://github.com/get-itips/msshells/edit/dev/index.markdown) against this page.

Looking for a complete list of Microsoft 365/Azure portals? Check out [https://msportals.io](https://msportals.io/) by [Adam Fowler](https://twitter.com/AdamFowler_IT).

## Am I running the most up-to-date version?
You can use the following PowerShell one-liner to check:

```powershell
Get-Module -ListAvailable MicrosoftTeams,ExchangeOnlineManagement,Microsoft.Online.SharePoint.PowerShell,AzureAD,AzureADPreview,WhiteboardAdmin,Microsoft.SharePoint.MigrationTool,MicrosoftPowerBIMgmt,Microsoft.PowerApps.Administration.PowerShell,Microsoft.PowerApps.PowerShell,MSCommerce | Format-Table Name,Version
```

## Maintainer
- [Andrés Gorzelany](https://twitter.com/andresgorzelany)

## Contributors
- [Robert Dyjas](https://twitter.com/robdyy)


