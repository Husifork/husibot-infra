targetScope = 'subscription'

//param environment string 1 
param appServicePlanNameGestorDocumental string
param appServiceGestorDocumental string
param appServiceGestorDocumentalkind string
param location string
param tagproyecto string
param tagambiente string
param storageAccountName1 string
param staticwebAppPRName string
param staticwebAppPRsku string
param staticwebAppPRrepo string
param staticwebAppPRbranch string
param staticwebAppPRprovider string


module pr 'main-rsgr-pr-gestorcarga-001.bicep' = {
  name: 'deployToRSGR-PR-GESTORCARGA-001'
  scope: resourceGroup('RSGR-PR-GESTORCARGA-001')
  params: {
        location: location
        tagproyecto: tagproyecto
        tagambiente: tagambiente
        appServicePlanNameGestorDocumental: appServicePlanNameGestorDocumental
        appServiceGestorDocumental: appServiceGestorDocumental
        appServiceGestorDocumentalkind : appServiceGestorDocumentalkind
        storageAccountName1: storageAccountName1
        staticwebAppPRName : staticwebAppPRName
        staticwebAppPRsku : staticwebAppPRsku
        staticwebAppPRrepo : staticwebAppPRrepo
        staticwebAppPRbranch  : staticwebAppPRbranch
        staticwebAppPRprovider : staticwebAppPRprovider

  }
}
