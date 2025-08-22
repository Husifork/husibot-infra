targetScope = 'resourceGroup'

param location string = resourceGroup().location
param tagproyecto string
param tagambiente string
param storageAccountName1 string
param appServicePlanNameGestorDocumental string
param appServiceGestorDocumental string
param appServiceGestorDocumentalkind string
param staticwebAppPRName string
param staticwebAppPRsku string
param staticwebAppPRrepo string
param staticwebAppPRbranch string
param staticwebAppPRprovider string


module appServicePlan1 'modules/appServicePlan/appServicePlanAdministrador.bicep' = {
  name: 'deployAppServicePlan1'
  params: {
    location: location
    appServicePlanName: appServicePlanNameGestorDocumental
    tagproyecto: tagproyecto
    tagambiente: tagambiente
    kind: appServiceGestorDocumentalkind
    reserved: true  
  }
}

module appService1 'modules/appService/appService_linux.bicep' = {
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
    appServicePlan1
  ]
}

module storagePortal1 'modules/storageAccount/storageAccount.bicep' = {
  name: 'deployStorage1'
  params: {
    location: location
    storageAccountName: storageAccountName1
    tagproyecto: tagproyecto
    tagambiente: tagambiente
  }
}

module staticWebAppQA 'modules/staticWebApp/staticWebApp.bicep' = {
  name: 'staticWebAppPR'
  params: {
    staticWebAppName: staticwebAppPRName
    location: location
    skuName: staticwebAppPRsku
    tagproyecto: tagproyecto
    tagambiente: tagambiente
    repositoryUrl: staticwebAppPRrepo
    branch: staticwebAppPRbranch
    provider: staticwebAppPRprovider
  }
}

