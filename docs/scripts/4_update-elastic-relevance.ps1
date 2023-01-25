#Elastic config
$env = "accept"
$domain = "kiss-demo.nl"
$kibanaUrl = "https://kibana.$env.$domain"
$elasticPassword = "[!ChangeMe!]"

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
Invoke-WebRequest -UseBasicParsing -Uri "/internal/security/login" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="kibana.$env.kiss-demo.nl"
  "method"="POST"
  "path"="/internal/security/login"
  "scheme"="https"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json" `
-Body "{`"providerType`":`"basic`",`"providerName`":`"basic`",`"currentURL`":`"$kibanaUrl/login?msg=LOGGED_OUT`",`"params`":{`"username`":`"elastic`",`"password`":`"$elasticPassword`"}}"

$session.Cookies.GetCookies("$kibanaUrl")
Invoke-WebRequest -UseBasicParsing -Uri "$kibanaUrl/internal/app_search/engines/kiss-engine/search_settings" `
-Method "PUT" `
-WebSession $session `
-Headers @{
"authority"="$kibanaUrl"
  "method"="PUT"
  "path"="/internal/app_search/engines/kiss-engine/search_settings"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json" `
-Body "{`"search_fields`":{`"additional_urls`":{`"weight`":1},`"body_content`":{`"weight`":1},`"title`":{`"weight`":9},`"meta_keywords`":{`"weight`":4},`"meta_description`":{`"weight`":7},`"headings`":{`"weight`":2},`"links`":{`"weight`":1},`"user`":{`"weight`":1},`"url_path`":{`"weight`":1},`"object`":{`"weight`":6},`"id`":{`"weight`":1},`"object_meta`":{`"weight`":7}},`"result_fields`":{`"url_path_dir3`":{`"raw`":{}},`"last_crawled_at`":{`"raw`":{}},`"additional_urls`":{`"raw`":{}},`"body_content`":{`"raw`":{}},`"domains`":{`"raw`":{}},`"id`":{`"raw`":{}},`"title`":{`"raw`":{}},`"meta_keywords`":{`"raw`":{}},`"url`":{`"raw`":{}},`"url_scheme`":{`"raw`":{}},`"meta_description`":{`"raw`":{}},`"object_bron`":{`"raw`":{}},`"headings`":{`"raw`":{}},`"object_meta`":{`"raw`":{}},`"self`":{`"raw`":{}},`"links`":{`"raw`":{}},`"url_port`":{`"raw`":{}},`"user`":{`"raw`":{}},`"url_host`":{`"raw`":{}},`"url_path_dir2`":{`"raw`":{}},`"url_path`":{`"raw`":{}},`"url_path_dir1`":{`"raw`":{}},`"object`":{`"raw`":{}}},`"boosts`":{},`"precision`":6}"