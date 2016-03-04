###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 08/19/12
# Modified: 08/19/12
# Description: Export Site Collections and move to different database
###

# Set Owner
$owner = "DOMAIN\USER"
# Source Web
$web_source = "http://contoso.com/TESTSITE"
# Target Web
$web_target = "http://contoso.com/sites/TESTSITE"
$web = Get-SPWeb $web_source
# New SiteCollection-Name
$NewSCName = "TESTSITE"
# Path where to save the backup
$path = "C:\Backups\TESTSITE"
# Target ContentDB
$db_target = "TESTContentDB"
# Target WebApplication
$webapp_target = "TEST_WebApp"
# GUIDs in Array
$guids = @{}
# Fill the array below

Export-SPWeb -Identity $web_source -Path $path -IncludeUserSecurity -IncludeVersions all -NoFileCompression -Force

Write-Host "Create Content DB? (y/n)"
$cdb = Read-Host
if($cdb -eq "y" -or $cdb -eq "Y")
{
  # Create new ContentDB
  New-SPContentDatabase -Name $db_target -WebApplication $webapp_target
}

Write-Host "Create New SiteCollection? (y/n)"
$nsc = Read-Host
if($nsc -eq "y" -or $nsc -eq "Y")
{
  # Create new SiteCollection
  New-SPSite -Url $web_target -OwnerAlias $owner -Template $template -Name $NewSCName
}

Write-Host "Create New Site? (y/n)"
$ns = Read-Host
if($ns -eq "y" -or $ns -eq "Y")
{
  # Create new Site
  New-SPWeb -Url $subsite_target -Template $template -Name $NewSiteName
}

if($nsc -eq "y" -or $nsc -eq "Y")
{
  # Activate features
  for($i = 0; $i -lt $guids.Count; $i++)
  {
    "id: " +$i
    Enable-SPFeature -Identity $guids[$i] -Url $web_target
  }
}

Import-SPWeb -Identity $subsite_target -Path $path -IncludeUserSecurity -IncludeUserCustomAction All -NoFileCompression -Force

Write-Host "Move Site? (y/n)"
$move = Read-Host
if($move -eq "y" -or $move -eq "Y")
{
 # Move Site from Standard-ContentDB to new ContentDB
 Move-SPSite $web_target -DestinationDatabase $db_target -WarningAction Continue
}

$web.Dispose()
