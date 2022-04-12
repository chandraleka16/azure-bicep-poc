// Data Lake Template

param lakeName string
param location string
param ownerName string

resource etlPOCDataLake 'Microsoft.DataLakeStore/accounts@2016-11-01' = {
  location: location
  name: lakeName
  tags: {
    Owner: ownerName
  }
}
