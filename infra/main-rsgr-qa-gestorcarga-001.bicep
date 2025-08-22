targetScope = 'resourceGroup'

param location string = resourceGroup().location
param tagproyecto string
param tagambiente string
param acaEnvironmentName string
param containerAppName string
param containerImage string
param containerExternalIngress bool = true
param containerTargetPort int = 8080

module acaEnv 'modules/containerApps/environment.bicep' = {
  name: 'acaEnvironment'
  params: {
    acaEnvironmentName: acaEnvironmentName
    location: location
    tagproyecto: tagproyecto
    tagambiente: tagambiente
  }
}

// --- MÓDULO CONTAINER APP ---
module acaApp 'modules/containerApps/containerApp.bicep' = {
  name: 'acaApp'
  params: {
    containerAppName: containerAppName
    location: location
    managedEnvironmentId: acaEnv.outputs.managedEnvironmentId
    containerImage: containerImage
    externalIngress: containerExternalIngress
    targetPort: containerTargetPort
  }
//  dependsOn: [ acaEnv ]
}
