---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---


|To Administer|Module Name|Stable Version|How To Install|Preview Version|How To Install|How to Connect|Works in PS7?|
|-----------------|:--------------:|---------------|---------------|-----------------|---------------|-----------------|-----------------|
| Microsoft Teams | [MicrosoftTeams](https://www.powershellgallery.com/packages/MicrosoftTeams) |          2.6.0 | ```Install-Module MicrosoftTeams``` | 2.5.2-preview  | ```Install-Module MicrosoftTeams -RequiredVersion 2.5.2-preview -AllowPrerelease``` |```Connect-MicrosoftTeams``` [More methods](https://docs.microsoft.com/MicrosoftTeams/teams-powershell-install#sign-in)|No|
| Exchange Online | [ExchangeOnlineManagement](https://www.powershellgallery.com/packages/ExchangeOnlineManagement)  |2.0.5|```Install-Module -Name ExchangeOnlineManagement```|2.0.5|```Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.6-Preview3 -AllowPrerelease```|```Connect-ExchangeOnline``` [More methods](https://docs.microsoft.com/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa)|Yes|
| Security & Compliance        |[ExchangeOnlineManagement](https://www.powershellgallery.com/packages/ExchangeOnlineManagement)                |2.0.5                |```Install-Module -Name ExchangeOnlineManagement```|2.0.5|```Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.6-Preview3 -AllowPrerelease```|```Connect-IPPSSession``` [More methods](https://docs.microsoft.com/powershell/exchange/connect-to-scc-powershell?view=exchange-ps)|Yes|
|SharePoint Online|[Microsoft.Online.SharePoint.PowerShell](https://www.powershellgallery.com/packages/Microsoft.Online.SharePoint.PowerShell)|16.0.21714.12000|```Install-Module -Name Microsoft.Online.SharePoint.PowerShell```|N/A|N/A|```Connect-SPOService -Url https://contoso-admin.sharepoint.com -Credential admin@contoso.com``` [More methods](https://docs.microsoft.com/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps#to-connect-with-a-user-name-and-password) |No|
|Azure AD|[AzureAD](https://www.powershellgallery.com/packages/AzureAD)|2.0.2.140|```Install-Module -Name AzureAD```|See next row|N/A|```Connect-AzureAD``` [More methods](https://docs.microsoft.com/en-us/microsoft-365/enterprise/connect-to-microsoft-365-powershell?view=o365-worldwide#connect-with-the-azure-active-directory-powershell-for-graph-module)|No|
|Azure AD|[AzureADPreview](https://www.powershellgallery.com/packages/AzureADPreview/)|2.0.2.138|```Install-Module -Name AzureADPreview```|N/A|N/A|```Connect-AzureAD``` [More methods](https://docs.microsoft.com/en-us/microsoft-365/enterprise/connect-to-microsoft-365-powershell?view=o365-worldwide#connect-with-the-azure-active-directory-powershell-for-graph-module)|No|
|Azure Az PowerShell|[Az](https://www.powershellgallery.com/packages/Az/)|6.5.0|```Install-Module -Name Az```|N/A|N/A|```Connect-AzAccount``` [More methods](https://docs.microsoft.com/en-us/powershell/module/az.accounts/connect-azaccount)|Yes|
|Whiteboard|[WhiteboardAdmin](https://www.powershellgallery.com/packages/WhiteboardAdmin)|1.4.0|```Install-Module -Name WhiteboardAdmin```|N/A|N/A|Every cmdlet forces Auth prompt|No|
|MSOnline|[MSOnline](https://www.powershellgallery.com/packages/MSOnline/)|1.1.183.57|```Install-Module -Name MSOnline```|N/A|N/A|```Connect-MSolService``` [More methods](https://docs.microsoft.com/powershell/module/msonline/connect-msolservice?view=azureadps-1.0)|No|
|Whiteboard|[WhiteboardAdmin](https://www.powershellgallery.com/packages/WhiteboardAdmin)|1.4.0|```Install-Module -Name WhiteboardAdmin```|N/A|N/A|Every cmdlet forces Auth prompt|No|
|SharePoint Migration Tool|[Microsoft.SharePoint.MigrationTool](https://docs.microsoft.com/en-us/sharepointmigration/new-and-improved-features-in-the-sharepoint-migration-tool)|3.4.120.7|Tricky, see [here](https://aka.ms/spmt-ga-page) and [here](https://docs.microsoft.com/sharepointmigration/overview-spmt-ps-cmdlets#before-you-begin)|3.4.121.5|Tricky, see [here](https://spmtreleasescus.blob.core.windows.net/betainstall/default.htm) and [here](https://docs.microsoft.com/sharepointmigration/overview-spmt-ps-cmdlets#before-you-begin)|```Register-SPMTMigration``` [More info](https://docs.microsoft.com/powershell/module/spmt/register-spmtmigration?view=spmt-ps)|No|
|Rollup module for Power BI Cmdlets|[MicrosoftPowerBIMgmt](https://www.powershellgallery.com/packages/MicrosoftPowerBIMgmt)|1.2.1055|```Install-Module -Name MicrosoftPowerBIMgmt```|N/A|N/A|```Connect-PowerBIServiceAccount``` [More info](https://docs.microsoft.com/powershell/module/microsoftpowerbimgmt.profile/connect-powerbiserviceaccount?view=powerbi-ps)|No|
|PowerApps (Administrator)|[Microsoft.PowerApps.Administration.PowerShell](https://www.powershellgallery.com/packages/Microsoft.PowerApps.Administration.PowerShell)|2.0.138|```Install-Module -Name Microsoft.PowerApps.Administration.PowerShell```|N/A|N/A|```Add-PowerAppsAccount``` (Run as Administrator) [More methods](https://docs.microsoft.com/power-platform/admin/powerapps-powershell#installation)|No|
|PowerApps (Maker)|[Microsoft.PowerApps.PowerShell](https://www.powershellgallery.com/packages/Microsoft.PowerApps.PowerShell/)|1.0.20|```Install-Module -Name Microsoft.PowerApps.PowerShell```|N/A|N/A|```Add-PowerAppsAccount``` (Run as Administrator) [More methods](https://docs.microsoft.com/power-platform/admin/powerapps-powershell#installation)|No|
|MS Commerce|[MSCommerce](https://www.powershellgallery.com/packages/MSCommerce)|1.7|```Install-Module -Name MSCommerce```|N/A|N/A|```Connect-MSCommerce``` [More methods](https://docs.microsoft.com/power-bi/admin/service-admin-disable-self-service#change-the-self-service-signup-policy-1)|No|
|Microsoft Graph services|[Microsoft.Graph](https://www.powershellgallery.com/packages/Microsoft.Graph/)|1.7.0|```Install-Module -Name Microsoft.Graph```|N/A|N/A|```Connect-MgGraph``` [More methods](https://docs.microsoft.com/en-us/graph/powershell/get-started)|Yes|

Do you think a module is missing or has incorrect information? Please, let me know, either creating an [issue](https://github.com/get-itips/msshells/issues/new) or a [pull request](https://github.com/get-itips/msshells/edit/dev/index.markdown) against this page.

Looking for a complete list of Microsoft 365/Azure portals? Check out [https://msportals.io](https://msportals.io/) by [Adam Fowler](https://twitter.com/AdamFowler_IT).

## Am I running the most up-to-date version?
You can use the following PowerShell one-liner to check:

```powershell
Get-Module -ListAvailable MicrosoftTeams,ExchangeOnlineManagement,Microsoft.Online.SharePoint.PowerShell,AzureAD,AzureADPreview,Az,WhiteboardAdmin,Microsoft.SharePoint.MigrationTool,MicrosoftPowerBIMgmt,Microsoft.PowerApps.Administration.PowerShell,Microsoft.PowerApps.PowerShell,MSCommerce,Microsoft.Graph | Format-Table Name,Version
```

## Maintainer
- [Andrés Gorzelany](https://twitter.com/andresgorzelany)

## Contributors
- [Robert Dyjas](https://twitter.com/robdyy)
- [shivtorov](https://github.com/shivtorov)
- [Juraj Sucik](https://github.com/jurajsucik)



