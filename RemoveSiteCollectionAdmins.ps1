###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/22/15
# Modified: 07/22/15
# Description: Remove site collection admins from all sites
###


if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$w = $WebApp.Name
$removeSiteAdmins = ("domain\user1", "domain\user2")

start-transcript -path $w"_RemoveSCAdmin.txt"
"`r`n"
foreach($site in $webApp.Sites)
{
  write-host -Backgroundcolor Green -Foregroundcolor Black "Web: " $site.Url "`r`n"
  foreach($removeSiteAdmin in $removeSiteAdmins)
  {
    if($removeSiteAdmin.IsSiteAdmin -eq $true)
    {
      $removeSiteAdmin.IsSiteAdmin = $false
      $removeSiteAdmin.Update()
      write-host -Backgroundcolor Yellow -Foregroundcolor Black "Site Collection Admin removed: " $removeSiteAdmin.DisplayName " | " $removeSiteAdmin.LoginName "`r`n"
    }
  }
  "`r`n"
  $site.Dispose()
}

write-host -Backgroundcolor White -Foregroundcolor Black "Done." "`r`n"
read-host "Press ENTER to quit..." "`r`n"
stop-transcript
