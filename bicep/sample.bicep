// escreva um bicep para criar um novo Azure App Service, incluindo o Plano de Aplicativo e o App Service
// O Plano de Aplicativo deve ser criado com a SKU B1
// O App Service deve ser criado com a SKU B1
// O App Service deve ser associado ao Plano de Aplicativo
// O App Service deve ter a configuração de Always On habilitada
// O App Service deve ter a configuração de .Net 6.0 habilitada

param appServiceName string = 'demo-app-service-bicep-arruda'
param location string = 'brazilsouth'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServiceName
  location: location
  kind: 'app'
  sku: {
    name: 'B1'
    tier: 'BASIC'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      alwaysOn: true
      netFrameworkVersion: 'v6.0'
    }
  }
}

output webAppUrl string = webApp.properties.defaultHostName



