
param environmentName string
param location string

var resourceToken = uniqueString(subscription().id, resourceGroup().id, environmentName)
var rgName = resourceGroup().name

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'ai-${resourceToken}'
  location: location
  kind: 'web'
  tags: {
    'azd-env-name': environmentName
  }
  properties: {
    Application_Type: 'web'
  }
}

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'logs-${resourceToken}'
  location: location
  tags: {
    'azd-env-name': environmentName
  }
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource staticSite 'Microsoft.Web/staticSites@2024-04-01' = {
  name: 'swa-${resourceToken}'
  location: location
  sku: {
    name: 'Free'
  }
  tags: {
    'azd-env-name': environmentName
  }
  properties: {
    repositoryUrl: ''
    branch: ''
    buildProperties: {
      appLocation: ''
      outputLocation: ''
    }
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-${resourceToken}'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 30
    publicNetworkAccess: 'Enabled'
  }
  tags: {
    'azd-env-name': environmentName
  }
}


resource tagResourceGroup 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'tag-resource-group-${resourceToken}'
  location: location
  kind: 'AzurePowerShell'
  properties: {
    azPowerShellVersion: '10.0'
    scriptContent: '''
      param([string]$ResourceGroupName, [string]$AzdEnvName)
      if (![string]::IsNullOrEmpty($ResourceGroupName) -and ![string]::IsNullOrEmpty($AzdEnvName)) {
        Set-AzResourceGroup -Name $ResourceGroupName -Tag @{ "azd-env-name" = $AzdEnvName }
      } else {
        Write-Error "ResourceGroupName or AzdEnvName is null or empty."
      }
    '''
    arguments: '-ResourceGroupName "${rgName}" -AzdEnvName "${environmentName}"'
    timeout: 'PT5M'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

output staticSiteName string = staticSite.name
output staticSiteEndpoint string = staticSite.properties.defaultHostname
output RESOURCE_GROUP_ID string = resourceGroup().id
