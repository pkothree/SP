###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 3/23/17
# Modified: 3/23/17
# Description: Get all Community Sites
# TemplateID: 
#    Community Site(COMMUNITY#0, 62)
#    Community Portal(COMMUNITYPORTAL#0, 63)
#    Community Area Template (SPSCOMMU#0, 36)
###

# Vars
$webApp = WEBAPP

if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$w = Get-SPWebApplication $webApp
$webAppName = $w.Name

start-transcript -path $webAppName"_CommSites.txt"

# Get All SiteCollections
$sites = Get-SPSite -WebApplication $webApp -Limit All

# Iteriate through each SiteCollections
foreach($site in $sites)
{
    #$web = $site.OpenSite()
    $web = Get-SPWeb $site.url
    if($web.WebTemplateId -eq "62")
    {
        Write-Host $site.Url ";" $site.LastContentModifiedDate ";" $site.Owner "`r`n" -ForegroundColor"Green"
    }
}

$site.Dispose()

Stop-Transcript