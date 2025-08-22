targetScope = 'resourceGroup'

param acaEnvironmentName string
param location string = resourceGroup().location
param tagproyecto string
param tagambiente string

resource env 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: acaEnvironmentName
  location: location
  tags: {
    Proyecto: tagproyecto
    Ambiente: tagambiente
  }
  properties: {
    // Entorno de consumo (serverless). Free grant aplica automáticamente.
    zoneRedundant: false
  }
}

output managedEnvironmentId string = env.id
