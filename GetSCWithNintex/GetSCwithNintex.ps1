###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 3/23/17
# Modified: 4/25/17
# Description: Get all Site Collection from one Web Application with Nintex Workflow
###

# Vars
$webApp = "WEBAPP"

#"0561d315-d5db-4736-929e-26da142812c5" #Nintex Workflow, Scope: Site
#"2fb9d5df-2fb5-403d-b155-535c256be1dc" #NintexWorkflowEnterpriseWeb, Scope: Site
#"9bf7bf98-5660-498a-9399-bc656a61ed5d" #NintexWorkflowWeb, Scope: Web
$guids = @("0561d315-d5db-4736-929e-26da142812c5", "0561d315-d5db-4736-929e-26da142812c5")



if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$w = Get-SPWebApplication $webApp
$webAppName = $w.Name

start-transcript -path $webAppName"_Nintex.txt"

# Get All SiteCollections
$sites = Get-SPSite -WebApplication $webApp -Limit All

Write-Host "Site-URL;Owner" "`r"

# Iterate through each SiteCollections
foreach($site in $sites)
{
    foreach($feature in $site.Features)
    {		
		if($feature.DefinitionId -match [Guid]$guid)
        {
            Write-Host $site.Url ";" $site.Owner "`r" -ForegroundColor "Green"
        }
    }
}

Stop-Transcript
