###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/22/15
# Modified: 07/24/15
# Description: Add site collection admins to all sites
###



if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$w = $WebApp.Name
$newSiteAdmins = ("domain\user")

start-transcript -path $w"_AddSCAdmin.txt"

"`r`n"

foreach($site in $webApp.Sites)
{
  write-host -Backgroundcolor Green -Foregroundcolor Black "Web: " $site.Url "`r`n"
  $siteAdministrators = $site.RootWeb.SiteAdministrators
  $web = $site.RootWeb
    foreach($newSiteAdmin in $newSiteAdmins)
    {
      $addUser = Get-SPUser -Identity $newSiteAdmin -Web $web -ErrorAction Stop
      #if($addUser.IsSiteAdmin -ne $true)
      #{
        $addUser.IsSiteAdmin = $true
        $addUser.Update()
        write-host -Backgroundcolor Yellow -Foregroundcolor Black "New Site Collection Admin: " $addUser.DisplayName " | " $addUser.LoginName "`r`n"
      #}
      #write-host -Backgroundcolor Yellow -Foregroundcolor Black $siteAdmin.DisplayName "`r`n"
    }
  "`r`n"
  $web.Dispose()
  $site.Dispose()
}

write-host -Backgroundcolor White -Foregroundcolor Black "Done." "`r`n"
read-host "Press ENTER to quit..." "`r`n"
stop-transcript
