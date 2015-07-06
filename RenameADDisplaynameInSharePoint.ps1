if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

# Set site
$site = Get-SPSite SPSITE
# Set domain
$domain = "sp2013\"
# Set new prefix
$newPrefix = "lala-"
$users = $site.RootWeb.Users
foreach($login in $users)
{
  if($login.ToString().Contains("s-"))
  {
    # Get user name logins only represented by IDs (hopefully these are only AD groups)
    $login.ToString()

    $user = Get-SPUser -Identity $login -Web $site.RootWeb

    # Remove domain from display name
    $dispNameSplit = $user.DisplayName.ToString().Split("\")
    $dispNameSplit = $dispNameSplit[1]
    # Remove prefix from display name
    $dispNameSplit = $dispNameSplit.ToString().Split("-")
    $dispNameSplit = $dispNameSplit[1]
    # Build new display name
    $modDispName = $domain + $newPrefix + $dispNameSplit
    # Store new display name in user
    $user.DisplayName = $modDispName
    $user.Update()
  }
}
$site.Dispose()