if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}
$site = Get-SPSite http://yourservername/sites/yoursitecollection 
$groups = $site.RootWeb.sitegroups
$grpPreFix = "NEW-"
foreach ($grp in $groups) 
{
  if($grp.Name.StartsWith("OLD-"))
  {
    # Split the old prefix
    $grpName = $grp.name.split("OLD-")
    # Add the new Prefix to the old group name
    $grpCompleteName = $grpPreFix + $grpName[4]
    # Set the group name
    $grp.name = $grpCompleteName
    # Update the group
    $grp.Update()
  }
}
$site.Dispose()