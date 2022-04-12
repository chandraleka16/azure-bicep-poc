// Resource Group Template

param rgName string
param location string
param ownerName string

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2018-05-01' = {
  name: rgName
  location: location
  tags: {
    Owner: ownerName
  }
}

output rgName string = rgName
output rgLocation string = location
