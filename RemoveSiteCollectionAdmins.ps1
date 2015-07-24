###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/22/15
# Modified: 07/24/15
# Description: Remove site collection admins from all sites
###

if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$w = $WebApp.Name
$oldSiteAdmin = "domain\user"

start-transcript -path $w"_RemoveSCAdmin.txt"

"`r`n"

foreach($site in $webApp.Sites)
{
  write-host -Backgroundcolor Green -Foregroundcolor Black "Web: " $site.Url "`r`n"
  $siteAdministrators = $site.RootWeb.SiteAdministrators
  $web = $site.RootWeb
  try
  {
    $removeUser = Get-SPUser -Identity $oldSiteAdmin -Web $web -ErrorAction Stop
    if($removeUser.get_IsSiteAdmin() -eq $true)
    {
      $removeUser.IsSiteAdmin = $FALSE
      $removeUser.Update()
      write-host -Backgroundcolor Yellow -Foregroundcolor Black "Site Collection Admin removed: " $removeUser.DisplayName " | " $removeUser.LoginName "`r`n"
    }
  }
  catch
  {
    Write-Host "Error for user " $oldSiteAdmin "in site " $site.Url "`r`n"
  }
  "`r`n"
  $site.Dispose()
}

write-host -Backgroundcolor White -Foregroundcolor Black "Done." "`r`n"
read-host "Press ENTER to quit..." "`r`n"
stop-transcript
