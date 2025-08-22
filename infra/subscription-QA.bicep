targetScope = 'subscription'

param location string = resourceGroup().location
param tagproyecto string
param tagambiente string
param acaEnvironmentName string
param containerAppName string
param containerImage string
param containerExternalIngress bool = true
param containerTargetPort int = 8080



// Para el despliegue de los recursos en el grupo de recursos RSGR-QA-ADMIN-001
module qa 'main-rsgr-qa-gestorcarga-001.bicep' = {
  name: 'deployToRSGR-QA-GESTORCARGA-001'
  scope: resourceGroup('RSGR-QA-GESTORCARGA-001')
  params: {
      location: location
      tagproyecto: tagproyecto
      tagambiente: tagambiente
      acaEnvironmentName: acaEnvironmentName
      containerAppName: containerAppName
      containerImage: containerImage
      containerExternalIngress: containerExternalIngress
      containerTargetPort: containerTargetPort
  }
}
