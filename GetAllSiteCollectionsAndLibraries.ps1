###
# Danny Davis
# Get all Site Collection & Libraries
# Created: 3/27/15
# Modified: 3/27/15
###

# Vars
$webApp = WEBAPP

$siteCollNum = 0
$librariesNum = 0
$currentLibNum = 0

$w = Get-SPWebApplication $webApp
$webAppName = $w.Name

start-transcript -path $webAppName".txt"


if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

# Get All SiteCollections
$sites = Get-SPSite -WebApplication $webApp -Limit All

# Iteriate through each SiteCollections
foreach($site in $sites)
{
  Write-Host $site.Url "`r`n"

  $currentLibNum = 0

  try
  {
     # Get all Webs in SiteCollection
     $webCollection = $site.AllWebs
     foreach($web in $webCollection)
     {
     # Get all lists in a SiteCollection; libraries are lists, just with a different template
     foreach($list in $web.Lists)
     {
       # Check if current $list is a document library
       if($list.BaseTemplate -eq "DocumentLibrary")
       {
         $currentLibNum = $currentLibNum + 1
       }
       }
     }
   }

   catch
   {
     Write-Host "No permissions on " $site.Url "`r`n"
   }

   finally
   {
     $siteCollNum = $siteCollNum + 1
     $librariesNum = $librariesNum + $currentLibNum

     Write-Host "Number of libraries: " $currentLibNum "`r`n"
     Write-Host "`r`n"
   } 
}

Write-Host "Number of SiteCollections: " $siteCollNum "`r`n"
Write-Host "Number of libraries: " $librariesNum "`r`n"

stop-transcript