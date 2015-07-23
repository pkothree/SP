###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/22/15
# Modified: 07/22/15
# Description: Get all site collection admins from all sites
###


if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$w = $WebApp.Name

start-transcript -path $w"_GetSCAdmin.txt"
"`r`n"
foreach($site in $webApp.Sites)
{
  write-host -Backgroundcolor Green -Foregroundcolor Black "Web: " $site.Url "`r`n"
  $siteAdministrators = $site.RootWeb.SiteAdministrators
  foreach($siteAdmin in $siteAdministrators)
  {
    write-host -Backgroundcolor Yellow -Foregroundcolor Black $siteAdmin.DisplayName " | " $siteAdmin.LoginName "`r`n"
  }
  "`r`n"
  $site.Dispose()
}

write-host -Backgroundcolor White -Foregroundcolor Black "Done." "`r`n"
read-host "Press ENTER to quit..." "`r`n"
stop-transcript
