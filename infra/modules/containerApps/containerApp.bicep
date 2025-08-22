targetScope = 'resourceGroup'

param containerAppName string
param location string = resourceGroup().location
param managedEnvironmentId string
param containerImage string
param externalIngress bool = false
param targetPort int = 8080

resource app 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: managedEnvironmentId
    configuration: {
      // Solo crea ingress si quieres exponer la app
      ingress: externalIngress ? {
        external: true
        targetPort: targetPort
        transport: 'auto'
      } : null

      activeRevisionsMode: 'Single'
      // runtime: 'containerapp'  // <-- quitar: no válido en 2024-03-01
    }
    template: {
      containers: [
        {
          name: 'app'
          image: containerImage
          resources: {
            cpu: 1.0 / 2.0   // 0.5; usa esta forma si tu bicep se quejara del literal
            memory: '1Gi'    // string con unidad (Gi)
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
