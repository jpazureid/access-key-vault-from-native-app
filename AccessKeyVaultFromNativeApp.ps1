Add-Type -Path ".\Tools\Microsoft.IdentityModel.Clients.ActiveDirectory\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"

#
# Authorization &amp; resource Url
#
$tenantId = "yourtenant.onmicrosoft.com" 
$resource = "https://vault.azure.net" 
$clientId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
$redirectUri = "https://localhost"

#
# Authorization Url
#
$authUrl = "https://login.microsoftonline.com/$tenantId/" 

#
# Create AuthenticationContext for acquiring token 
# 
$authContext = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext $authUrl

#
# Acquire the authentication result
#
$platformParameters = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters -ArgumentList "Always"
$authResult = $authContext.AcquireTokenAsync($resource, $clientId, $redirectUri, $platformParameters).Result

if ($null -ne $authResult.AccessToken) {
    #
    # Compose the access token type and access token for authorization header
    #
    $headerParams = @{'Authorization' = "$($authResult.AccessTokenType) $($authResult.AccessToken)"}

    #
    # Access Key Vault
    #
    $url = "https://yourkeyvault.vault.azure.net/secrets/SQLPassword?api-version=2016-10-01"
    $result = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $url)
    $secret = ($result.Content | ConvertFrom-Json).value
    
    Write-Output "Secret: $secret"
}
else {
    Write-Host "ERROR: No Access Token"
}
