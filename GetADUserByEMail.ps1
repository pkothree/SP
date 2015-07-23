###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 07/23/15
# Modified: 07/23/15
# Description: Get AD User by e-Mail address
###

$domainserver = get-addomaincontroller -discover -service ADWS -domainname DOMAIN
$ds = new-object Microsoft.ActiveDirectory.Management.ADPropertyValueCollection($domainserver.hostname)
foreach($value in $ds)
{
  $aduser = get-aduser -server $value -filter {emailaddress -eq "EMAIL"}
}
