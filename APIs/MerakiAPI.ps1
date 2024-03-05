$Headers = @{
    'X-Cisco-Meraki-API-Key' = ''
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
    }

# Get organizations
#$uri = 'https://api.meraki.com/api/v1/organizations'

# Get Networks
#$uri = 'https://api.meraki.com/api/v1/organizations/ORGIDGOESHERE/networks'

# Get Devices
$uri = 'https://api.meraki.com/api/v1/organizations/ORGIDGOESHERE/networks/NETWORKIDGOESHERE/devices'



Invoke-RestMethod -Uri $uri -Headers $Headers -Method Get | Format-Table


