###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 4/25/17
# Modified: 4/25/17
# Description: Get all Site Collections that are using InfoPath Form in any form
###

# Vars
$webApp = "WEBAPP"

if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$w = Get-SPWebApplication $webApp
$webAppName = $w.Name

start-transcript -path $webAppName"_SCWithInfoPath.txt"

# Get All SiteCollections
$sites = Get-SPSite -WebApplication $webApp -Limit All

Write-Host "Site-URL;Owner;List-URL" "`r"

# Iterate through each SiteCollections
foreach($site in $sites)
{
    $web = Get-SPWeb $site.URL
    foreach($list in $web.Lists)
    {
        if($list.BaseType -eq "DocumentLibrary" -and $list.BaseTemplate -eq "XMLForm")
        {
            Write-Host $site.Url ";" $site.Owner ";" $list.Rootfolder.URL "`r" -ForegroundColor "Green"
        }
        elseif ($list.ContentTypes[0].ResourceFolder.Properties["_ipfs_infopathenabled"])
        {
            Write-Host $site.Url ";" $site.Owner ";" $list.Rootfolder.URL "`r" -ForegroundColor "Green"
        }
    }
}

$site.Dispose()

Stop-Transcript