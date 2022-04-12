// Main Template

// Common params
param location string = 'eastus2'
var namePrefix = 'ivcpoc'
var ownerName = 'Chandraleka'

// Resource Group Params
var rgSubscriptionId = '635f7d5b-4fd3-47c3-a9e9-57b47433ad43'

// Blob Store Params
param blobstoreAccessTier string = 'Hot'
param blobstoreKind string = 'StorageV2'
param blobstorePublicAccess string = 'Container'
param blobstoreSku string = 'Standard_LRS'

// SQL DB Params
param sqlDBCollation string = 'SQL_Latin1_General_CP1_CI_AS'

// Stream Analytics Job Params
param saJobStreamingUnits int = 24
param saJobValidStreamingUnits int = 48


// Resource Group Module
module ivcResourceGroup 'modules/resource-group/resource-group.bicep' = {
  name: '${namePrefix}rg-deployment'
  params: {
    location: location
    rgName: '${namePrefix}rg-${location}-001'
    ownerName: ownerName
  }
  scope: subscription(rgSubscriptionId)
}

// Data Factory Module
module ivcDataFactory 'modules/data-factory/factory.bicep' = {
  name: '${namePrefix}data-factory-deployment'
  params: {
    factoryName: '${namePrefix}factory001'
    location: ivcResourceGroup.outputs.rgLocation
    ownerName: ownerName
  }
}

// Data Lake Module
module ivcDataLake 'modules/data-lake/lake.bicep' = {
  name: '${namePrefix}data-lake-deployment'
  params: {
    lakeName: '${namePrefix}lake001'
    location: ivcResourceGroup.outputs.rgLocation
    ownerName: ownerName
  }
}

// Blob Store Module
module ivcBlobStore 'modules/blob-store/blob-store.bicep' = {
  name: '${namePrefix}blob-store-deployment'
  params: {
    location: ivcResourceGroup.outputs.rgLocation
    sku: blobstoreSku
    kind: blobstoreKind
    publicAccess: blobstorePublicAccess
    accessTier: blobstoreAccessTier
    ownerName: ownerName
    storageAccountName: '${namePrefix}storageaccount001'
    blobStoreName: '${namePrefix}datablob001'
  }
}

// SQL DB Module
module ivcSQLDB 'modules/sql-db/sql-db.bicep' = {
  name: '${namePrefix}sql-db-deployment'
  params: {
    collation: sqlDBCollation
    DBName: '${namePrefix}sqldb-001'
    location: ivcResourceGroup.outputs.rgLocation
    elasticPoolName: '${namePrefix}sqldb-ep-001'
    ownerName: ownerName
    serverName: '${namePrefix}sqldb-server-001'
  }
}

// Stream Analytics Job Module
module ivcStreamAnalyticsJob 'modules/stream-analytics/sa-job.bicep' = {
  name: '${namePrefix}sa-job-deployment'
  params: {
    jobTransformationName: '${namePrefix}sa-job-transform'
    location: ivcResourceGroup.outputs.rgLocation
    streamAnalyticsJobName: '${namePrefix}sa-job-001'
    streamingUnits: saJobStreamingUnits
    validStreamingUnits: saJobValidStreamingUnits
  }
}


