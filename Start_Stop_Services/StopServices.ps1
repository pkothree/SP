###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 03/04/16
# Modified: 03/04/16
# Description: Stop Windows Services
###

$services= "Service1", "Service2", "..."

foreach($serviceName in $services)
{
  Stop-Service -Name $serviceName
  Set-Service -Name $serviceName -startuptype "disabled"
  $service =Get-Service $serviceName
  $service.WaitForStatus('Stopped')
  Write-Host "Service: " $serviceName " stopped."
}
