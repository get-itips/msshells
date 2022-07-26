---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

{% assign ps_mods = site.ps_modules | sort: "order" %}

| To Administer | Module Name | Stable Version | How To Install | Preview Version | How To Install | How to Connect | Works in PS7? |
| ------------- | :---------: | -------------- | -------------- | --------------- | -------------- | -------------- | ------------- |
{% for module in ps_mods %}| {{ module.toAdminister }}| [{{ module.name }}]({% if module.link %}{{ module.link }}{% else %}  https://www.powershellgallery.com/packages/{{ module.name }}{% endif %}) | {{ module.stableVersion }} | {% if module.howToInstall %}```Install-Module -Name {{ module.name }}```{% else %}```Install-Module -Name {{ module.name }}```{% endif %} | {{ module.previewVersion }} | {{ module.howToInstallPre | strip_newlines }} | {{ module.howToConnect | strip_newlines}} | {{ module.PS7 | toString }} |
{% endfor %}

**Note: PnP.PowerShell** is not a Microsoft provided module, is open-source and community provided library with active community providing support for it. Decided to include as an exception as it is very popular to administer Microsoft 365 stuff.

Do you think a module is missing or has incorrect information? Please, let me know, either creating an [issue](https://github.com/get-itips/msshells/issues/new) or a [pull request](https://github.com/get-itips/msshells/edit/dev/index.markdown) against this page.

Looking for a complete list of Microsoft 365/Azure portals? Check out [https://msportals.io](https://msportals.io/) by [Adam Fowler](https://twitter.com/AdamFowler_IT).

## Am I running the most up-to-date version?
You can use the following PowerShell one-liner to check:

<!--- ps_mods[0] used to avoid leading/trailing comma -->
```powershell
Get-Module -ListAvailable {{ ps_mods[0].name}}{% for module in ps_mods offset:2 %},{{ module.name }}{% endfor %} | Format-Table Name,Version
```

## Maintainer
- [Andrés Gorzelany](https://twitter.com/andresgorzelany)

## Contributors
- [Robert Dyjas](https://twitter.com/robdyy)
- [shivtorov](https://github.com/shivtorov)
- [Juraj Sucik](https://github.com/jurajsucik)



