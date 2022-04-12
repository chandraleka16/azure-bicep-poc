// Blob Store Template

param storageAccountName string
param location string
param kind string
param accessTier string
param publicAccess string
param sku string
param ownerName string
param blobStoreName string

resource etlPOCStorageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  kind: kind
  properties: {
    accessTier: accessTier
  }
  tags: {
    Owner: ownerName
  }
  sku: {
    name: sku
  }
}

resource etlPOCSAContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  name: blobStoreName
  properties: {
    publicAccess: publicAccess
  }
}
