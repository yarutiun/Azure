param location string = resourceGroup().location
// param storageAccountName string = 'devcamp060623'
param globalRedundancy bool = true
var unique = uniqueString(resourceGroup().id)

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'storage${unique}'
  location: location
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  name: '${storageAccount.name}/default/container${unique}'
  properties: {
    publicAccess: 'None'
  }
}

output storageAccountId string = storageAccount.id
output containerPrimaryEndpoints string = storageAccount.properties.primaryEndpoints.blob
