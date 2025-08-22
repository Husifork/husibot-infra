targetScope = 'subscription'

param location string
param tagproyecto string
param tagambiente string
param appServicePlanNameGestorDocumental string
param appServiceGestorDocumental string
param appServiceGestorDocumentalkind string
param staticwebAppQAName string
param staticwebAppQAsku string
param staticwebAppQArepo string
param staticwebAppQAbranch string
param staticwebAppQAprovider string
param sqlServerName string
@secure()
param sqlAdministratorLogin string
@secure()
param sqlAdministratorPassword string
param sqlDatabaseName1 string
param sqlDatabaseSku1 string
param sqlDatabaseName2 string
param sqlDatabaseSku2 string


// Para el despliegue de los recursos en el grupo de recursos RSGR-QA-ADMIN-001
module qa 'main-rsgr-qa-gestorcarga-001.bicep' = {
  name: 'deployToRSGR-QA-GESTORCARGA-001'
  scope: resourceGroup('RSGR-QA-GESTORCARGA-001')
  params: {
        location: location
        tagproyecto: tagproyecto
        tagambiente: tagambiente
        appServicePlanNameGestorDocumental: appServicePlanNameGestorDocumental
        appServiceGestorDocumental: appServiceGestorDocumental
        appServiceGestorDocumentalkind : appServiceGestorDocumentalkind
        staticwebAppQAName : staticwebAppQAName
        staticwebAppQAsku : staticwebAppQAsku
        staticwebAppQArepo : staticwebAppQArepo
        staticwebAppQAbranch : staticwebAppQAbranch
        staticwebAppQAprovider : staticwebAppQAprovider
        sqlServerName: sqlServerName
        sqlAdministratorLogin: sqlAdministratorLogin
        sqlAdministratorPassword: sqlAdministratorPassword
        sqlDatabaseName1: sqlDatabaseName1
        sqlDatabaseSku1: sqlDatabaseSku1
        sqlDatabaseName2: sqlDatabaseName2
        sqlDatabaseSku2: sqlDatabaseSku2
  }
}
