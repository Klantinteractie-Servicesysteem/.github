#Elastic config
$env = "accept"
$domain = "kiss-demo.nl"
$kibanaUrl = "https://kibana.$env.$domain"
$crawlerDomain = "[!ChangeMe!]" #bv "https://gemeente.nl"
$elasticPassword = "[!ChangeMe!]"

Write-Output "Elastic login"
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
Invoke-WebRequest -UseBasicParsing -Uri "$kibanaUrl/internal/security/login" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="$kibanaUrl"
  "method"="POST"
  "path"="/internal/security/login"
  "scheme"="https"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json" `
-Body "{`"providerType`":`"basic`",`"providerName`":`"basic`",`"currentURL`":`"$kibanaUrl/login?msg=LOGGED_OUT`",`"params`":{`"username`":`"elastic`",`"password`":`"$elasticPassword`"}}"

$session.Cookies.GetCookies("$kibanaUrl")

Write-Output "Maak engine aan"
Invoke-WebRequest -UseBasicParsing -Uri "$kibanaUrl/internal/app_search/engines" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="$kibanaUrl"
  "method"="POST"
  "path"="/internal/app_search/engines"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json" `
-Body "{`"name`":`"kiss-engine`",`"language`":`"nl`"}"

Write-Output "Maak crawler aan"
Invoke-WebRequest -UseBasicParsing -Uri "$kibanaUrl/internal/app_search/engines/kiss-engine/crawler/domains?respond_with=crawler_details" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="$kibanaUrl"
  "method"="POST"
  "path"="/internal/app_search/engines/kiss-engine/crawler/domains?respond_with=crawler_details"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json" `
-Body "{`"name`":`"$crawlerDomain`",`"entry_points`":[{`"value`":`"/`"}]}"

Write-Output "Start de crawler"
Invoke-WebRequest -UseBasicParsing -Uri "$kibanaUrl/internal/app_search/engines/kiss-engine/crawler/crawl_requests" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="$kibanaUrl"
  "method"="POST"
  "path"="/internal/app_search/engines/kiss-engine/crawler/crawl_requests"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json"

#todo index example object

#Update relevance tuning

Write-Output "Klaar met bijwerken elastic"
