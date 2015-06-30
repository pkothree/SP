#Just some PowerShell Commands I'm always forgetting


#Get environment variables
Get-ChildItem Env:

#Get certificates
Get-ChildItem -Recurse cert:

#Get events from a certain Type
Get-SPLogEvent | ?{$_.Area -eq "Excel Services Application" -And $_.Category -eq "Data Model" } | Format-List