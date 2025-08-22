targetScope = 'subscription'

param deployments array

resource rgs 'Microsoft.Resources/resourceGroups@2022-09-01' = [for d in deployments: {
  name: d.resourceGroupName
  location: d.location
}]
