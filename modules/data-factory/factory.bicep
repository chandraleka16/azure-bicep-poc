// Data Factory Template

param location string
param factoryName string
param ownerName string

resource etlPOCDataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: factoryName
  location: location
  tags: {
    Owner: ownerName
  }
}
