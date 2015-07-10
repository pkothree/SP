# SP
SharePoint PowerShell Scripts


# GetAllSiteCollectionsAndLibraries.ps1
You only have to edit line #9 "$webApp = WEBAPP". Change "WEBAPP" to the actual web application you want to crawl through. <br>
The script will count site collections and libraries, it is also able to display the number of libraries in the current site collection. It is important to note that the script will only look for libraries with the base template "DocumentLibary". This will also include system relevant libraries.<br>
If you are not allowed to crawl through a specific site collection you will get the error "No permissions on " including the site collection.<br>
The script will create a transcript in the same folder as the script is running in, the file name will be the name of the web application.

# RenameSharePointGroups.ps1
Changes you will have to make:<br>
Line #13: "$site = Get-SPSite http://yourservername/sites/yoursitecollection" <br>
Edit the site collection, so the script can run on the correct site collection.<br>
<br>
Line #15: "$grpPreFix = "NEW-""<br>
Replace "NEW-", add the new prefix you want your groups to have.<br>
<br>
Line #18: "if($grp.Name.StartsWith("OLD-"))"<br>
Replace "OLD-", add the old prefix you want to replace.<br>

# GetExpiringCertificates.ps1
The script will get every certificate that will expire in less than or equal 90 days.

# ActivateAlternateLanguages.ps1
You only have to edit line #14 "$webApp = WEBAPP". Change "WEBAPP" to the actual web application you want to crawl through. <br>
This script will go through every site collection within a web app and it will activate other supported ui cultures if multilanguage is supported. To support multilanguage on all site collections just use line #19, this will active multilanguae support.
