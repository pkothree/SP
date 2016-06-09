###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 06/09/16
# Modified: 06/09/16
# Description: Get Site Collections from a specific ContentDB
###

Get-SPSite -Limit All  -ContentDatabase CONTENTDB | select url, @{label="Size";Expression={$_.usage.storage}}
