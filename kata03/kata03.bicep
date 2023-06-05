param containerNames array
var uniqueSuffix = uniqueString(resourceGroup().id)
resource existingStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'storage2aeubapu4bmjk'
  scope: resourceGroup('yura02')
}
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = [for (name, i) in containerNames: {
  name: '${existingStorageAccount.name}/default/${name}${uniqueSuffix}'
  properties: {
    publicAccess: 'None'
  }
}]
