###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 02/17/16
# Modified: 02/17/16
# Description: Get Quotas of Site Collections
###

Import-Module ".\GetQuotaModule.ps1"

$siteCollections = ("SC1", "SC2")

get-scquota $siteCollections
Write-Host "Done."
