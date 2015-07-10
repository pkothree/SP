###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/10/15
# Modified: 07/10/15
###

if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$webApp = Get-SPWebApplication WEBAPP

foreach($site in $webApp.Sites)
{
  $web = $site.Rootweb

  # If you want to automatically activate languages on all Sites
  #$web.IsMultilingual = $true;

  # Check if Multilanguage Support is activated
  # If so, activate all the other available languages
  if($web.IsMultilingual -eq $true)
  {
    foreach($culture in $web.SupportedUICultures)
    {
      $web.AddSupportedUICulture($culture.LCID)
      $web.Update()
    }
  }
  $web.Dispose()
}
