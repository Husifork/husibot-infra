param name string
param location string
@secure()
param administratorLogin string
@secure()
param administratorLoginPassword string
param version string = '12.0' // Default a la versión común de SQL
param tagproyecto string
param tagambiente string
param minimalTlsVersion string = '1.2' // Default a TLS 1.2
param publicNetworkAccess string = 'Enabled'

resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
  name: name
  location: location
  tags: {
    Proyecto: tagproyecto
    Ambiente: tagambiente
  }
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    version: version
    minimalTlsVersion: minimalTlsVersion
    publicNetworkAccess: publicNetworkAccess
  }
}

output serverName string = sqlServer.name
output serverId string = sqlServer.id
