###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 03/04/16
# Modified: 03/04/16
# Description: Start Windows Services
###

$services= "Service1", "Service2", "..."

foreach($serviceName in $services)
{
  Set-Service -Name $serviceName -startuptype "automatic"
  Start-Service -Name $serviceName
  $service =Get-Service $serviceName
  $service.WaitForStatus('Running')
  Write-Host "Service: " $serviceName " started."
}
