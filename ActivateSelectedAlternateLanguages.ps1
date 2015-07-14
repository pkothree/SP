###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/10/15
# Modified: 07/10/15
# Description: Activate selected alternate languages on all site collections
###

if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP
$languages = ("English","French","German")

foreach($site in $webApp.Sites)
{
  $web = $site.Rootweb
  $RegionSettings = New-Object Microsoft.SharePoint.SPRegionalSettings($web)
  foreach($language in $languages)
  {
    if($language -eq $RegionSettings.InstalledLanguages.DisplayName)
    {
      $LCID = $RegionSettings.InstalledLanguages.LCID
      # If you want to automatically activate languages on all Sites
      #$web.IsMultilingual = $true;

      # Check if Multilanguage Support is activated
      # If so, activate all the other available languages
      if($web.IsMultilingual -eq $true)
      {
        $web.AddSupportedUICulture($LCID)
        $web.Update()
      }
    }
  }
  $web.Dispose()
}
