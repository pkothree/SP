###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/10/15
# Modified: 07/15/15
# Description: Activate all alternate languages on all site collections
###


if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$w = $WebApp.Name

start-transcript -path $w".txt"

foreach($site in $webApp.Sites)
{
  $web = $site.Rootweb
  write-host -Backgroundcolor Green -Foregroundcolor Black "Web: " $web.Url "`r`n"
  # If you want to automatically activate languages on all Sites
  $web.IsMultilingual = $true;
  write-host -Backgroundcolor Green -Foregroundcolor Black "Multilanguage allowed:" $web.IsMultilingual "`r`n"

  #Get installed languages
  $RegionSettings = New-Object Microsoft.SharePoint.SPRegionalSettings($web)
  $regLangs = $RegionSettings.InstalledLanguages
  # Check if Multilanguage Support is activated
  # If so, activate all the other available languages
  if($web.IsMultilingual -eq $true)
  {
    foreach($regLang in $regLangs)
    {
      $LCID = $regLang.LCID
      $web.AddSupportedUICulture($LCID)
      write-host -Backgroundcolor Yellow -Foregroundcolor Black "Language " $regLang.DisplayName  " / " $LCID " added." "`r`n"
    }
  }
  $web.Update()
  "`r`n"
  $web.Dispose()
}
write-host -Backgroundcolor White -Foregroundcolor Black "Done." "`r`n"
read-host "Press ENTER to quit..." "`r`n"
stop-transcript
