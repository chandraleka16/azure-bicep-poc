// SQL Server template

param serverName string
param location string
param DBName string
param collation string
param elasticPoolName string
param ownerName string

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' = {
  name: serverName
  location: location
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: DBName
  location: location
  properties: {
    collation: collation
    elasticPoolName: elasticPoolName
  }
  tags: {
    Owner: ownerName
  }
}
