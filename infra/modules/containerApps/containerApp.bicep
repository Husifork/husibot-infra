targetScope = 'resourceGroup'

param containerAppName string
param location string = resourceGroup().location
param managedEnvironmentId string
param containerImage string
param externalIngress bool
param targetPort int

// Forzamos valores en variables para evitar problemas de parseo en línea
var fixedCpu = 0.5
var fixedMemory = '1Gi'

resource app 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: managedEnvironmentId
    configuration: {
      // incluir ingress solo si externalIngress es true
      ingress: externalIngress ? {
        external: true
        targetPort: targetPort
        transport: 'auto'
      } : null
      activeRevisionsMode: 'Single'
    }
    template: {
      containers: [
        {
          name: 'app'
          image: containerImage
          resources: {
            cpu: fixedCpu
            memory: fixedMemory
          }
        }
      ]
      scale: {
        minReplicas: 0
        maxReplicas: 1
      }
    }
  }
}
