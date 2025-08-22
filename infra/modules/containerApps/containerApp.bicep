targetScope = 'resourceGroup'

param containerAppName string
param location string = resourceGroup().location
param managedEnvironmentId string
param containerImage string
param externalIngress bool
param targetPort int
resource app 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: managedEnvironmentId
    configuration: {
      ingress: {
        external: externalIngress
        targetPort: targetPort
        transport: 'auto'
      }
      activeRevisionsMode: 'Single'
      runtime: 'containerapp'
    }
    template: {
      containers: [
        {
          name: 'app'
          image: containerImage
          resources: {
            cpu: 0.5          // valor fijo
            memory: '1.0Gi'   // valor fijo
          }
        }
      ]
      scale: {
        minReplicas: 0       // valor fijo
        maxReplicas: 1       // valor fijo
      }
    }
  }
}
