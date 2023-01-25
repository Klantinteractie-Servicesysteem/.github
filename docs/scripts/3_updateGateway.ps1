$env = "accept"
$url = "$env.kiss-demo.nl"
$fullUrl = "https://$url"
$openWebUrl = "https://openweb.$env.kiss-demo.nl/wp-json/wp/v2"

$gateway_username = "admin@$url"
$gateway_password = "[!ChangeMe!]"
$elasticPassword = "[!ChangeMe!]"

#Elastic config
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://kibana.$url/internal/security/login" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="kibana.$url"
  "method"="POST"
  "path"="/internal/security/login"
  "scheme"="https"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json" `
-Body "{`"providerType`":`"basic`",`"providerName`":`"basic`",`"currentURL`":`"https://kibana.$url/login?msg=LOGGED_OUT`",`"params`":{`"username`":`"elastic`",`"password`":`"$elasticPassword`"}}"

$session.Cookies.GetCookies("https://kibana.$url")

$response = Invoke-WebRequest -UseBasicParsing -Uri "https://kibana.$url/internal/app_search/credentials/details" `
-WebSession $session `
-Headers @{
"authority"="kibana.$url"
  "method"="GET"
  "path"="/internal/app_search/credentials/details"
  "scheme"="https"
  "kbn-version"="7.17.3"
} `
-ContentType "application/json"

$response = $response.Content | ConvertFrom-Json
$private = $response.apiTokens.Where{$_.name -eq "private-key" } | Select-Object -first 1
$privateKey = $private.key
$search = $response.apiTokens.Where{$_.name -eq "search-key" } | Select-Object -first 1
$searchKey = $search.key

#Gateway login
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")

$body = "{
`n    `"username`": `"$gateway_username`",
`n    `"password`": `"$gateway_password`"
`n}"

$response = Invoke-RestMethod "$fullUrl/api/users/login" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
$bearer = "Bearer "+$response.jwtToken

#Get gateway endpoints
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", $bearer)


$privateResponse = Invoke-RestMethod "$fullUrl/admin/gateways?name=EnterpriseSearch API Private" -Method 'GET' -Headers $headers
$privateResponse | ConvertTo-Json
$elasticPrivateSourceId = $privateResponse.'hydra:member'[0].id


$searchResponse = Invoke-RestMethod "$fullUrl/admin/gateways?name=EnterpriseSearch API Search" -Method 'GET' -Headers $headers
$searchResponse | ConvertTo-Json
$elasticSearchSourceId = $searchResponse.'hydra:member'[0].id


$pubResponse = Invoke-RestMethod "$fullUrl/admin/gateways?name=OpenPub API" -Method 'GET' -Headers $headers
$pubResponse | ConvertTo-Json
$openPubSourceId = $pubResponse.'hydra:member'[0].id


$searchResponse = Invoke-RestMethod "$fullUrl/admin/gateways?name=EnterpriseSearch API Search" -Method 'GET' -Headers $headers
$searchResponse | ConvertTo-Json
$elasticSearchSourceId = $searchResponse.'hydra:member'[0].id


#Update gateway endpoints
$body = "{
    `n    `"apikey`": `"Bearer $privateKey`"
    `n}"
Invoke-RestMethod "$fullUrl/admin/gateways/$elasticPrivateSourceId" -Method 'PUT' -Headers $headers  -Body $body

$body = "{
    `n    `"apikey`": `"Bearer $searchKey`"
    `n}"
Invoke-RestMethod "$fullUrl/admin/gateways/$elasticSearchSourceId" -Method 'PUT' -Headers $headers  -Body $body

$body = "{
    `n    `"location`": `"$openWebUrl`"
    `n}"
Invoke-RestMethod "$fullUrl/admin/gateways/$openPubSourceId" -Method 'PUT' -Headers $headers  -Body $body

#Get elastic triggers and execute
$SyncEmployeeElasticActionResponse = Invoke-RestMethod "$fullUrl/admin/actions?name=SyncEmployeeElasticAction" -Method 'GET' -Headers $headers
$SyncEmployeeElasticActionResponse | ConvertTo-Json
$SyncEmployeeElastic = $SyncEmployeeElasticActionResponse.'hydra:member'[0].id
$SyncKennisArtikelElasticActionResponse = Invoke-RestMethod "$fullUrl/admin/actions?name=SyncKennisArtikelElasticAction" -Method 'GET' -Headers $headers
$SyncKennisArtikelElasticActionResponse | ConvertTo-Json
$SyncKennisArtikel = $SyncKennisArtikelElasticActionResponse.'hydra:member'[0].id
Invoke-RestMethod "$fullUrl/admin/run_action/$SyncEmployeeElastic" -Method 'POST' -Headers $headers -Body "{}"
Invoke-RestMethod "$fullUrl/admin/run_action/$SyncKennisArtikel" -Method 'POST' -Headers $headers -Body "{}"

$SyncPubActionResponse = Invoke-RestMethod "$fullUrl/admin/actions?name=SyncPubAction" -Method 'GET' -Headers $headers
$SyncPubActionResponse | ConvertTo-Json
$openPubTrigger = $SyncPubActionResponse.'hydra:member'[0].id
Invoke-RestMethod "$fullUrl/admin/run_action/$openPubTrigger" -Method 'POST' -Headers $headers -Body "{}"
