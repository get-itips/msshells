---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

{% assign ps_mods = site.ps_modules | sort: "order" %}

| To Administer | Module Name | Stable Version | How To Install | Preview Version | How To Install | How to Connect | Works in PS7? |
| ------------- | :---------: | -------------- | -------------- | --------------- | -------------- | -------------- | ------------- |
{% for module in ps_mods %}| {{ module.toAdminister }}| [{{ module.name }}](https://www.powershellgallery.com/packages/{{ module.Name }}) | {{ module.stableVersion }} | {{ module.howToInstall | strip_newlines }} | {{ module.previewVersion }} | {{ module.howToInstallPre | strip_newlines }} | {{ module.howToConnect | strip_newlines}} | {{ module.PS7 | toString }} 
{% endfor %}


Do you think a module is missing or has incorrect information? Please, let me know, either creating an [issue](https://github.com/get-itips/msshells/issues/new) or a [pull request](https://github.com/get-itips/msshells/edit/dev/index.markdown) against this page.

Looking for a complete list of Microsoft 365/Azure portals? Check out [https://msportals.io](https://msportals.io/) by [Adam Fowler](https://twitter.com/AdamFowler_IT).

## Am I running the most up-to-date version?
You can use the following PowerShell one-liner to check:

```powershell
Get-Module -ListAvailable MicrosoftTeams,ExchangeOnlineManagement,Microsoft.Online.SharePoint.PowerShell,AzureAD,AzureADPreview,Az,WhiteboardAdmin,Microsoft.SharePoint.MigrationTool,MicrosoftPowerBIMgmt,Microsoft.PowerApps.Administration.PowerShell,Microsoft.PowerApps.PowerShell,MSCommerce,Microsoft.Graph,UniversalPrintManagement | Format-Table Name,Version
```

## Maintainer
- [Andrés Gorzelany](https://twitter.com/andresgorzelany)

## Contributors
- [Robert Dyjas](https://twitter.com/robdyy)
- [shivtorov](https://github.com/shivtorov)
- [Juraj Sucik](https://github.com/jurajsucik)



