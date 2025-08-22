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
      // Solo incluir ingress si quieres exponer
      ingress: externalIngress ? {
        external: true
        targetPort: targetPort
        transport: 'auto'
      } : null

      activeRevisionsMode: 'Single'
      // runtime: 'containerapp'  // <- quitar, no es válido en este apiVersion
    }
    template: {
      containers: [
        {
          name: 'app'
          image: containerImage
          resources: {
            cpu: 1.0 / 2.0   // 0.5; usa esta forma si tu bicep se queja del literal
            memory: '1Gi'    // <-- STRING con unidad; p.ej. '1Gi', '2Gi'
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
