targetScope = 'resourceGroup'

param location string = resourceGroup().location
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
param sqlDatabaseName2 string
param sqlDatabaseSku1 string
param sqlDatabaseSku2 string


module appServicePlan 'modules/appServicePlan/appServicePlanAdministrador.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    location: location
    appServicePlanName: appServicePlanNameGestorDocumental
    tagproyecto: tagproyecto
    tagambiente: tagambiente
    kind: appServiceGestorDocumentalkind
    reserved: true
  }
}

 module appServicesGD 'modules/appService/appService_linux.bicep' = {
  name: 'deployAppServiceGestorDocumental'
  params: {
    location: location
    appServiceName: appServiceGestorDocumental
    appServicePlanName: appServicePlanNameGestorDocumental
    virtualNetworkSubnetId: ''
    tagproyecto: tagproyecto
    tagambiente: tagambiente
    linuxFxVersion: 'DOTNETCORE|8.0' //.NET 8.0 .
    kind: appServiceGestorDocumentalkind
    reserved: true
  }
    dependsOn: [
    appServicePlan
  ]

}

module staticWebAppQA 'modules/staticWebApp/staticWebApp.bicep' = {
  name: 'staticWebAppQA'
  params: {
    staticWebAppName: staticwebAppQAName
    location: location
    skuName: staticwebAppQAsku
    tagproyecto: tagproyecto
    tagambiente: tagambiente
    repositoryUrl: staticwebAppQArepo
    branch: staticwebAppQAbranch
    provider: staticwebAppQAprovider
  }
}

//despliegue de SQL Server y base de datos
module sqlServerModule 'modules/sqlServer/sqlServer.bicep' = {
  name: 'asql-gestorcarga-001'
  params: {
    name: sqlServerName
    location: location
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorPassword
    tagproyecto: tagproyecto
    tagambiente: tagambiente
  }
}

module sqlDatabaseModule1 'modules/sqlDatabase/sqlDatabase.bicep' = {
  name: 'sqlDatabaseDeploymentQA'
  params: {
    name: sqlDatabaseName1
    location: location
    serverName: sqlServerModule.outputs.serverName
    skuName: sqlDatabaseSku1
    tagproyecto: tagproyecto
    tagambiente: tagambiente
  }
}

module sqlDatabaseModule2 'modules/sqlDatabase/sqlDatabase.bicep' = {
  name: 'sqlDatabaseDeploymentPR'
  params: {
    name: sqlDatabaseName2
    location: location
    serverName: sqlServerModule.outputs.serverName
    skuName: sqlDatabaseSku2
    tagproyecto: tagproyecto
    tagambiente: tagambiente
  }
}

