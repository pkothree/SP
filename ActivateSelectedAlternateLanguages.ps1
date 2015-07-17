###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/17/15
# Modified: 07/17/15
# Description: Activate selected alternate languages on all root collections
###

if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$languages = ("English","French","German", "Spanish")
$w = $WebApp.Name

start-transcript -path $w".txt"

foreach($site in $webApp.Sites)
{
  $web = $site.Rootweb
  write-host -Backgroundcolor Green -Foregroundcolor Black "Web: " $web "`r`n"
  $RegionSettings = New-Object Microsoft.SharePoint.SPRegionalSettings($web)
  foreach($language in $languages)
  {
  $regLangs = $RegionSettings.InstalledLanguages
  foreach($regLang in $regLangs)
  {
    if($language -eq $regLang.DisplayName)
    {
      $LCID = $regLang.LCID
      # If you want to automatically activate languages on all Sites
      $web.IsMultilingual = $true;
      write-host -Backgroundcolor Green -Foregroundcolor Black "Multilanguage allowed:" $web.IsMultilingual "`r`n"
      # Check if Multilanguage Support is activated
      # If so, activate all the other available languages
      if($web.IsMultilingual -eq $true)
      {
        $web.AddSupportedUICulture($LCID)
        write-host -Backgroundcolor Yellow -Foregroundcolor Black  "Language " $language  " / " $LCID " added." "`r`n"
        $web.Update()
      }
    }
  }
  }
  $web.Dispose()
}
write-host -Backgroundcolor White -Foregroundcolor Black "Done." "`r`n"
read-host "Press ENTER to quit..." "`r`n"
stop-transcript
