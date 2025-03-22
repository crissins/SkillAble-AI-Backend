@secure()
param datastores_rag_secretsType string

@secure()
param datastores_ragdata_secretsType string

@secure()
param datastores_workspaceartifactstore_secretsType string

@secure()
param datastores_workspaceblobstore_secretsType string

@secure()
param datastores_workspaceworkingdirectory_secretsType string
param serverfarms_EastUSPlan_name string = 'EastUSPlan'
param sites_united_coach_web_app_name string = 'united-coach-web-app'
param sites_united_coach_pdf_processor_name string = 'united-coach-pdf-processor'
param vaults_unite_coach_key_vault_name string = 'unite-coach-key-vault'
param components_united_coach_web_app_name string = 'united-coach-web-app'
param components_united_coach_front_end_name string = 'united-coach-front-end'
param storageAccounts_united0coach0storage_name string = 'united0coach0storage'
param accounts_united_coach_openai_name string = 'united-coach-openai'
param accounts_united_coach_speech_name string = 'united-coach-speech'
param components_united_coach_pdf_processor_name string = 'united-coach-pdf-processor'
param databaseAccounts_united_coach_cosmos_name string = 'united-coach-cosmos'
param accounts_united_coach_video_indexer_name string = 'united-coach-video-indexer'
param accounts_unitedcoachaih1164957527_name string = 'unitedcoachaih1164957527'
param workspaces_united_coach_llms_name string = 'united-coach-llms'
param serverfarms_ASP_innovationchallengemarch2025_9230_name string = 'ASP-innovationchallengemarch2025-9230'
param workspaces_united_coach_ai_hub_name string = 'united-coach-ai-hub'
param CommunicationServices_united_coach_emails_name string = 'united-coach-emails'
param emailServices_united_coach_email_provider_name string = 'united-coach-email-provider'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param accounts_united_coach_document_intelligence_name string = 'united-coach-document-intelligence'
param userAssignedIdentities_united_coach_fro_id_b346_name string = 'united-coach-fro-id-b346'
param smartdetectoralertrules_failure_anomalies_united_coach_web_app_name string = 'failure anomalies - united-coach-web-app'
param smartdetectoralertrules_failure_anomalies_united_coach_front_end_name string = 'failure anomalies - united-coach-front-end'
param smartdetectoralertrules_failure_anomalies_united_coach_pdf_processor_name string = 'failure anomalies - united-coach-pdf-processor'
param workspaces_DefaultWorkspace_2e620f84_5d37_4a3d_8d06_fff7450c1fdd_EUS2_externalid string = '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/DefaultResourceGroup-EUS2/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-2e620f84-5d37-4a3d-8d06-fff7450c1fdd-EUS2'
param workspaces_DefaultWorkspace_2e620f84_5d37_4a3d_8d06_fff7450c1fdd_EUS_externalid string = '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/DefaultResourceGroup-EUS/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-2e620f84-5d37-4a3d-8d06-fff7450c1fdd-EUS'
param storageAccounts_unitedcoachaih6178051034_externalid string = '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/Microsoft.Storage/storageAccounts/unitedcoachaih6178051034'
param components_united_coach_app_insights_externalid string = '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/Microsoft.Insights/components/united-coach-app-insights'
param registries_unitedcoach_externalid string = '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/Microsoft.ContainerRegistry/registries/unitedcoach'

resource accounts_unitedcoachaih1164957527_name_resource 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: accounts_unitedcoachaih1164957527_name
  location: 'southcentralus'
  sku: {
    name: 'S0'
  }
  kind: 'AIServices'
  properties: {
    customSubDomainName: accounts_unitedcoachaih1164957527_name
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_united_coach_document_intelligence_name_resource 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: accounts_united_coach_document_intelligence_name
  location: 'eastus'
  sku: {
    name: 'S0'
  }
  kind: 'FormRecognizer'
  identity: {
    type: 'None'
  }
  properties: {
    customSubDomainName: accounts_united_coach_document_intelligence_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_united_coach_openai_name_resource 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: accounts_united_coach_openai_name
  location: 'eastus'
  sku: {
    name: 'S0'
  }
  kind: 'OpenAI'
  properties: {
    apiProperties: {}
    customSubDomainName: accounts_united_coach_openai_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_united_coach_speech_name_resource 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: accounts_united_coach_speech_name
  location: 'eastus'
  sku: {
    name: 'F0'
  }
  kind: 'SpeechServices'
  identity: {
    type: 'None'
  }
  properties: {
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource emailServices_united_coach_email_provider_name_resource 'Microsoft.Communication/emailServices@2023-06-01-preview' = {
  name: emailServices_united_coach_email_provider_name
  location: 'global'
  properties: {
    dataLocation: 'United States'
  }
}

resource databaseAccounts_united_coach_cosmos_name_resource 'Microsoft.DocumentDB/databaseAccounts@2024-12-01-preview' = {
  name: databaseAccounts_united_coach_cosmos_name
  location: 'West US 3'
  tags: {
    defaultExperience: 'Core (SQL)'
    'hidden-workload-type': 'Development/Testing'
    'hidden-cosmos-mmspecial': ''
  }
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'None'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableAnalyticalStorage: false
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    databaseAccountOfferType: 'Standard'
    enableMaterializedViews: false
    capacityMode: 'Serverless'
    defaultIdentity: 'FirstPartyIdentity'
    networkAclBypass: 'None'
    disableLocalAuth: false
    enablePartitionMerge: false
    enablePerRegionPerPartitionAutoscale: false
    enableBurstCapacity: false
    enablePriorityBasedExecution: false
    defaultPriorityLevel: 'High'
    minimalTlsVersion: 'Tls12'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    locations: [
      {
        locationName: 'West US 3'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    cors: []
    capabilities: []
    ipRules: []
    backupPolicy: {
      type: 'Periodic'
      periodicModeProperties: {
        backupIntervalInMinutes: 240
        backupRetentionIntervalInHours: 8
        backupStorageRedundancy: 'Geo'
      }
    }
    networkAclBypassResourceIds: []
    diagnosticLogSettings: {
      enableFullTextQuery: 'None'
    }
    capacity: {
      totalThroughputLimit: 4000
    }
  }
}

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2024-10-01-preview' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource components_united_coach_front_end_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_united_coach_front_end_name
  location: 'eastus2'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_2e620f84_5d37_4a3d_8d06_fff7450c1fdd_EUS2_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource components_united_coach_pdf_processor_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_united_coach_pdf_processor_name
  location: 'eastus'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_2e620f84_5d37_4a3d_8d06_fff7450c1fdd_EUS_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource components_united_coach_web_app_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_united_coach_web_app_name
  location: 'eastus2'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_2e620f84_5d37_4a3d_8d06_fff7450c1fdd_EUS2_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource vaults_unite_coach_key_vault_name_resource 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: vaults_unite_coach_key_vault_name
  location: 'southcentralus'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: '00869294-f950-4f33-ba27-235c5064d921'
    accessPolicies: [
      {
        tenantId: '00869294-f950-4f33-ba27-235c5064d921'
        objectId: '87db2e05-bb25-4bdc-a1a0-326c3b38d97f'
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          storage: []
        }
      }
      {
        tenantId: '00869294-f950-4f33-ba27-235c5064d921'
        objectId: '9e87437c-1ed7-46dd-ab0b-fd379b81ea5c'
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          storage: []
        }
      }
    ]
    enabledForDeployment: false
    enableSoftDelete: true
    vaultUri: 'https://${vaults_unite_coach_key_vault_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentities_united_coach_fro_id_b346_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30' = {
  name: userAssignedIdentities_united_coach_fro_id_b346_name
  location: 'eastus2'
}

resource storageAccounts_united0coach0storage_name_resource 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccounts_united0coach0storage_name
  location: 'eastus'
  tags: {
    ProjectType: 'aoai-your-data-service'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_ASP_innovationchallengemarch2025_9230_name_resource 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: serverfarms_ASP_innovationchallengemarch2025_9230_name
  location: 'East US 2'
  sku: {
    name: 'P0v3'
    tier: 'Premium0V3'
    size: 'P0v3'
    family: 'Pv3'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource serverfarms_EastUSPlan_name_resource 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: serverfarms_EastUSPlan_name
  location: 'East US'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource accounts_unitedcoachaih1164957527_name_Default 'Microsoft.CognitiveServices/accounts/defenderForAISettings@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource accounts_united_coach_openai_name_Default 'Microsoft.CognitiveServices/accounts/defenderForAISettings@2024-10-01' = {
  parent: accounts_united_coach_openai_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource accounts_unitedcoachaih1164957527_name_DeepSeek_V3 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'DeepSeek-V3'
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {
    model: {
      format: 'DeepSeek'
      name: 'DeepSeek-V3'
      version: '1'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 1
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_unitedcoachaih1164957527_name_gpt_4o_mini 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'gpt-4o-mini'
  sku: {
    name: 'GlobalStandard'
    capacity: 250
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o-mini'
      version: '2024-07-18'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 250
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_united_coach_openai_name_gpt_4o_mini 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: accounts_united_coach_openai_name_resource
  name: 'gpt-4o-mini'
  sku: {
    name: 'GlobalStandard'
    capacity: 250
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o-mini'
      version: '2024-07-18'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 250
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_unitedcoachaih1164957527_name_Phi_4_mini_instruct 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'Phi-4-mini-instruct'
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {
    model: {
      format: 'Microsoft'
      name: 'Phi-4-mini-instruct'
      version: '1'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 1
    raiPolicyName: 'Microsoft.Default'
  }
}

resource accounts_unitedcoachaih1164957527_name_Phi_4_multimodal_instruct 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'Phi-4-multimodal-instruct'
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {
    model: {
      format: 'Microsoft'
      name: 'Phi-4-multimodal-instruct'
      version: '1'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 1
    raiPolicyName: 'Microsoft.Default'
  }
}

resource accounts_unitedcoachaih1164957527_name_text_embedding_3_large 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'text-embedding-3-large'
  sku: {
    name: 'GlobalStandard'
    capacity: 150
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'text-embedding-3-large'
      version: '1'
    }
    versionUpgradeOption: 'NoAutoUpgrade'
    currentCapacity: 150
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_unitedcoachaih1164957527_name_Microsoft_Default 'Microsoft.CognitiveServices/accounts/raiPolicies@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'Microsoft.Default'
  properties: {
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
    ]
  }
}

resource accounts_united_coach_openai_name_Microsoft_Default 'Microsoft.CognitiveServices/accounts/raiPolicies@2024-10-01' = {
  parent: accounts_united_coach_openai_name_resource
  name: 'Microsoft.Default'
  properties: {
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
    ]
  }
}

resource accounts_unitedcoachaih1164957527_name_Microsoft_DefaultV2 'Microsoft.CognitiveServices/accounts/raiPolicies@2024-10-01' = {
  parent: accounts_unitedcoachaih1164957527_name_resource
  name: 'Microsoft.DefaultV2'
  properties: {
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Jailbreak'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Protected Material Text'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Protected Material Code'
        blocking: false
        enabled: true
        source: 'Completion'
      }
    ]
  }
}

resource accounts_united_coach_openai_name_Microsoft_DefaultV2 'Microsoft.CognitiveServices/accounts/raiPolicies@2024-10-01' = {
  parent: accounts_united_coach_openai_name_resource
  name: 'Microsoft.DefaultV2'
  properties: {
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Jailbreak'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Protected Material Text'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Protected Material Code'
        blocking: false
        enabled: true
        source: 'Completion'
      }
    ]
  }
}

resource CommunicationServices_united_coach_emails_name_resource 'Microsoft.Communication/CommunicationServices@2024-09-01-preview' = {
  name: CommunicationServices_united_coach_emails_name
  location: 'global'
  properties: {
    dataLocation: 'United States'
    linkedDomains: [
      emailServices_united_coach_email_provider_name_AzureManagedDomain.id
    ]
  }
}

resource emailServices_united_coach_email_provider_name_AzureManagedDomain 'Microsoft.Communication/emailServices/domains@2023-06-01-preview' = {
  parent: emailServices_united_coach_email_provider_name_resource
  name: 'AzureManagedDomain'
  location: 'global'
  properties: {
    domainManagement: 'AzureManaged'
    userEngagementTracking: 'Disabled'
  }
}

resource databaseAccounts_united_coach_cosmos_name_united_coach_container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_resource
  name: 'united-coach-container'
  properties: {
    resource: {
      id: 'united-coach-container'
    }
  }
}

resource databaseAccounts_united_coach_cosmos_name_united_coach_database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_resource
  name: 'united-coach-database'
  properties: {
    resource: {
      id: 'united-coach-database'
    }
  }
}

resource databaseAccounts_united_coach_cosmos_name_00000000_0000_0000_0000_000000000001 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_resource
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_united_coach_cosmos_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource databaseAccounts_united_coach_cosmos_name_00000000_0000_0000_0000_000000000002 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_resource
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_united_coach_cosmos_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource Microsoft_DocumentDB_databaseAccounts_tableRoleDefinitions_databaseAccounts_united_coach_cosmos_name_00000000_0000_0000_0000_000000000001 'Microsoft.DocumentDB/databaseAccounts/tableRoleDefinitions@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_resource
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_united_coach_cosmos_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/entities/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource Microsoft_DocumentDB_databaseAccounts_tableRoleDefinitions_databaseAccounts_united_coach_cosmos_name_00000000_0000_0000_0000_000000000002 'Microsoft.DocumentDB/databaseAccounts/tableRoleDefinitions@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_resource
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_united_coach_cosmos_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/tables/*'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/entities/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource components_united_coach_front_end_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'degradationindependencyduration'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'degradationindependencyduration'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'degradationindependencyduration'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'degradationinserverresponsetime'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'degradationinserverresponsetime'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'degradationinserverresponsetime'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'digestMailConfiguration'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'digestMailConfiguration'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'digestMailConfiguration'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'extension_canaryextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'extension_canaryextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'extension_canaryextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'extension_memoryleakextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'extension_memoryleakextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'extension_memoryleakextension'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'extension_securityextensionspackage'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'extension_securityextensionspackage'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'extension_securityextensionspackage'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'extension_traceseveritydetector'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'extension_traceseveritydetector'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'extension_traceseveritydetector'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'longdependencyduration'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'longdependencyduration'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'longdependencyduration'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'slowpageloadtime'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'slowpageloadtime'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'slowpageloadtime'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_front_end_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_front_end_name_resource
  name: 'slowserverresponsetime'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_pdf_processor_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_pdf_processor_name_resource
  name: 'slowserverresponsetime'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_united_coach_web_app_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_united_coach_web_app_name_resource
  name: 'slowserverresponsetime'
  location: 'eastus2'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource vaults_unite_coach_key_vault_name_bbcdb877_b029_4b81_9669_84e1e95cf665_unitedcoachaih1164957527 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'bbcdb877-b029-4b81-9669-84e1e95cf665-unitedcoachaih1164957527'
  location: 'southcentralus'
  properties: {
    contentType: 'WorkspaceConnectionSecret'
    attributes: {
      enabled: true
      exp: 1805363413
    }
  }
}

resource vaults_unite_coach_key_vault_name_bbcdb877_b029_4b81_9669_84e1e95cf665_unitedcoachaih1164957527aoai 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'bbcdb877-b029-4b81-9669-84e1e95cf665-unitedcoachaih1164957527aoai'
  location: 'southcentralus'
  properties: {
    contentType: 'WorkspaceConnectionSecret'
    attributes: {
      enabled: true
      exp: 1805363410
    }
  }
}

resource vaults_unite_coach_key_vault_name_f709dc2f_f815_4d8c_b2cc_9ff9ae42447d_rag20250321040042690 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-rag20250321040042690'
  location: 'southcentralus'
  properties: {
    contentType: 'application/vnd.ms-StorageAccountAccessKey'
    attributes: {
      enabled: true
      exp: 1805601642
    }
  }
}

resource vaults_unite_coach_key_vault_name_f709dc2f_f815_4d8c_b2cc_9ff9ae42447d_ragdata20250321040308147 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-ragdata20250321040308147'
  location: 'southcentralus'
  properties: {
    contentType: 'application/vnd.ms-StorageAccountAccessKey'
    attributes: {
      enabled: true
      exp: 1805601788
    }
  }
}

resource vaults_unite_coach_key_vault_name_f709dc2f_f815_4d8c_b2cc_9ff9ae42447d_workspaceartifactstore00010101000000000 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-workspaceartifactstore00010101000000000'
  location: 'southcentralus'
  properties: {
    contentType: 'application/vnd.ms-StorageAccountAccessKey'
    attributes: {
      enabled: true
      exp: 1805364297
    }
  }
}

resource vaults_unite_coach_key_vault_name_f709dc2f_f815_4d8c_b2cc_9ff9ae42447d_workspaceblobstore00010101000000000 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-workspaceblobstore00010101000000000'
  location: 'southcentralus'
  properties: {
    contentType: 'application/vnd.ms-StorageAccountAccessKey'
    attributes: {
      enabled: true
      exp: 1805364296
    }
  }
}

resource vaults_unite_coach_key_vault_name_f709dc2f_f815_4d8c_b2cc_9ff9ae42447d_workspaceworkingdirectory00010101000000000 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = {
  parent: vaults_unite_coach_key_vault_name_resource
  name: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-workspaceworkingdirectory00010101000000000'
  location: 'southcentralus'
  properties: {
    contentType: 'application/vnd.ms-StorageAccountAccessKey'
    attributes: {
      enabled: true
      exp: 1805364296
    }
  }
}

resource workspaces_united_coach_llms_name_rag 'Microsoft.MachineLearningServices/workspaces/datastores@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/rag'
  properties: {
    credentials: {
      credentialsType: 'AccountKey'
      secrets: {
        secretsType: datastores_rag_secretsType
      }
    }
    subscriptionId: '2e620f84-5d37-4a3d-8d06-fff7450c1fdd'
    resourceGroup: 'innovation-challenge-march-2025'
    datastoreType: 'AzureBlob'
    accountName: 'united0coach0storage'
    containerName: 'pdfs'
    endpoint: 'core.windows.net'
    protocol: 'https'
    serviceDataAccessAuthIdentity: 'None'
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource workspaces_united_coach_llms_name_ragdata 'Microsoft.MachineLearningServices/workspaces/datastores@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/ragdata'
  properties: {
    credentials: {
      credentialsType: 'AccountKey'
      secrets: {
        secretsType: datastores_ragdata_secretsType
      }
    }
    subscriptionId: '2e620f84-5d37-4a3d-8d06-fff7450c1fdd'
    resourceGroup: 'innovation-challenge-march-2025'
    datastoreType: 'AzureBlob'
    accountName: 'united0coach0storage'
    containerName: 'rag-data'
    endpoint: 'core.windows.net'
    protocol: 'https'
    serviceDataAccessAuthIdentity: 'None'
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource workspaces_united_coach_llms_name_workspaceartifactstore 'Microsoft.MachineLearningServices/workspaces/datastores@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/workspaceartifactstore'
  properties: {
    credentials: {
      credentialsType: 'Sas'
      secrets: {
        secretsType: datastores_workspaceartifactstore_secretsType
      }
    }
    datastoreType: 'AzureBlob'
    accountName: 'unitedcoachaih6178051034'
    containerName: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-azureml'
    endpoint: 'core.windows.net'
    protocol: 'https'
    serviceDataAccessAuthIdentity: 'None'
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource workspaces_united_coach_llms_name_workspaceblobstore 'Microsoft.MachineLearningServices/workspaces/datastores@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/workspaceblobstore'
  properties: {
    credentials: {
      credentialsType: 'Sas'
      secrets: {
        secretsType: datastores_workspaceblobstore_secretsType
      }
    }
    subscriptionId: '2e620f84-5d37-4a3d-8d06-fff7450c1fdd'
    resourceGroup: 'innovation-challenge-march-2025'
    datastoreType: 'AzureBlob'
    accountName: 'unitedcoachaih6178051034'
    containerName: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-azureml-blobstore'
    endpoint: 'core.windows.net'
    protocol: 'https'
    serviceDataAccessAuthIdentity: 'WorkspaceSystemAssignedIdentity'
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource workspaces_united_coach_llms_name_workspaceworkingdirectory 'Microsoft.MachineLearningServices/workspaces/datastores@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/workspaceworkingdirectory'
  properties: {
    credentials: {
      credentialsType: 'AccountKey'
      secrets: {
        secretsType: datastores_workspaceworkingdirectory_secretsType
      }
    }
    datastoreType: 'AzureFile'
    accountName: 'unitedcoachaih6178051034'
    fileShareName: 'f709dc2f-f815-4d8c-b2cc-9ff9ae42447d-code'
    endpoint: 'core.windows.net'
    protocol: 'https'
    serviceDataAccessAuthIdentity: 'None'
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource userAssignedIdentities_united_coach_fro_id_b346_name_crissins_SkillAble_AI_Frontend_840a 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2024-11-30' = {
  parent: userAssignedIdentities_united_coach_fro_id_b346_name_resource
  name: 'crissins-SkillAble-AI-Frontend-840a'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:crissins/SkillAble-AI-Frontend:environment:Production'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}

resource userAssignedIdentities_united_coach_fro_id_b346_name_jh44wjjcrkv2y 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2024-11-30' = {
  parent: userAssignedIdentities_united_coach_fro_id_b346_name_resource
  name: 'jh44wjjcrkv2y'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:crissins/unitedcoach:environment:Production'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}

resource storageAccounts_united0coach0storage_name_default 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: [
        {
          allowedOrigins: [
            'https://*.videoindexer.ai'
          ]
          allowedMethods: [
            'GET'
            'OPTIONS'
          ]
          maxAgeInSeconds: 200
          exposedHeaders: [
            '*'
          ]
          allowedHeaders: [
            '*'
          ]
        }
        {
          allowedOrigins: [
            'http://localhost:3000'
          ]
          allowedMethods: [
            'POST'
            'PUT'
          ]
          maxAgeInSeconds: 40000
          exposedHeaders: [
            '*'
          ]
          allowedHeaders: [
            '*'
          ]
        }
      ]
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_united0coach0storage_name_default 'Microsoft.Storage/storageAccounts/fileServices@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_united0coach0storage_name_default 'Microsoft.Storage/storageAccounts/queueServices@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_united0coach0storage_name_default 'Microsoft.Storage/storageAccounts/tableServices@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_united_coach_pdf_processor_name_resource 'Microsoft.Web/sites@2024-04-01' = {
  name: sites_united_coach_pdf_processor_name
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-pdf-processor'
    'hidden-link: /app-insights-instrumentation-key': 'e384de8b-90f3-4685-be61-fba9d5ebbb67'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e384de8b-90f3-4685-be61-fba9d5ebbb67;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/;ApplicationId=60b5c1ea-c613-40f6-addb-9611ad1a3a6f'
  }
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_united_coach_pdf_processor_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_united_coach_pdf_processor_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_EastUSPlan_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: true
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'EA8D5ADCE637BBB33B41B8674318B6FD35808598E63EAF099192C841AE78B804'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_united_coach_web_app_name_resource 'Microsoft.Web/sites@2024-04-01' = {
  name: sites_united_coach_web_app_name
  location: 'East US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-web-app'
    'hidden-link: /app-insights-instrumentation-key': 'c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601;IngestionEndpoint=https://eastus2-3.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus2.livediagnostics.monitor.azure.com/;ApplicationId=07ceb05b-a010-401d-910a-5f637613fbe1'
  }
  kind: 'app,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_united_coach_web_app_name}-h3c9dneuf2acgcfv.eastus2-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_united_coach_web_app_name}-h3c9dneuf2acgcfv.scm.eastus2-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_innovationchallengemarch2025_9230_name_resource.id
    reserved: true
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'NODE|20-lts'
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'EA8D5ADCE637BBB33B41B8674318B6FD35808598E63EAF099192C841AE78B804'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
    autoGeneratedDomainNameLabelScope: 'TenantReuse'
  }
}

resource sites_united_coach_pdf_processor_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: 'ftp'
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-pdf-processor'
    'hidden-link: /app-insights-instrumentation-key': 'e384de8b-90f3-4685-be61-fba9d5ebbb67'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e384de8b-90f3-4685-be61-fba9d5ebbb67;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/;ApplicationId=60b5c1ea-c613-40f6-addb-9611ad1a3a6f'
  }
  properties: {
    allow: true
  }
}

resource sites_united_coach_web_app_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_united_coach_web_app_name_resource
  name: 'ftp'
  location: 'East US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-web-app'
    'hidden-link: /app-insights-instrumentation-key': 'c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601;IngestionEndpoint=https://eastus2-3.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus2.livediagnostics.monitor.azure.com/;ApplicationId=07ceb05b-a010-401d-910a-5f637613fbe1'
  }
  properties: {
    allow: false
  }
}

resource sites_united_coach_pdf_processor_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: 'scm'
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-pdf-processor'
    'hidden-link: /app-insights-instrumentation-key': 'e384de8b-90f3-4685-be61-fba9d5ebbb67'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e384de8b-90f3-4685-be61-fba9d5ebbb67;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/;ApplicationId=60b5c1ea-c613-40f6-addb-9611ad1a3a6f'
  }
  properties: {
    allow: true
  }
}

resource sites_united_coach_web_app_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_united_coach_web_app_name_resource
  name: 'scm'
  location: 'East US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-web-app'
    'hidden-link: /app-insights-instrumentation-key': 'c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601;IngestionEndpoint=https://eastus2-3.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus2.livediagnostics.monitor.azure.com/;ApplicationId=07ceb05b-a010-401d-910a-5f637613fbe1'
  }
  properties: {
    allow: false
  }
}

resource sites_united_coach_pdf_processor_name_web 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: 'web'
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-pdf-processor'
    'hidden-link: /app-insights-instrumentation-key': 'e384de8b-90f3-4685-be61-fba9d5ebbb67'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e384de8b-90f3-4685-be61-fba9d5ebbb67;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/;ApplicationId=60b5c1ea-c613-40f6-addb-9611ad1a3a6f'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v8.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$united-coach-pdf-processor'
    scmType: 'ExternalGit'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: true
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource sites_united_coach_web_app_name_web 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: sites_united_coach_web_app_name_resource
  name: 'web'
  location: 'East US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/microsoft.insights/components/united-coach-web-app'
    'hidden-link: /app-insights-instrumentation-key': 'c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=c0f16f1d-6ae4-4ee9-9c0c-b7d27ca96601;IngestionEndpoint=https://eastus2-3.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus2.livediagnostics.monitor.azure.com/;ApplicationId=07ceb05b-a010-401d-910a-5f637613fbe1'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'NODE|20-lts'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'GitHubAction'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: true
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: true
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    elasticWebAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource sites_united_coach_pdf_processor_name_3cbcad69d7a8ca2f5f6b1d2b7637241624cd49db 'Microsoft.Web/sites/deployments@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: '3cbcad69d7a8ca2f5f6b1d2b7637241624cd49db'
  location: 'East US'
  properties: {
    status: 4
    author_email: 'crissins041196@gmail.com'
    author: 'Cristopher Hugo Olivares Del Real'
    deployer: 'GitHub'
    message: 'feat: email functionality\n'
    start_time: '2025-03-22T01:45:49.4088711Z'
    end_time: '2025-03-22T01:45:50.6276079Z'
    active: true
  }
}

resource sites_united_coach_pdf_processor_name_4cf5ba798d814c12b7a3d6fffffa7e29 'Microsoft.Web/sites/deployments@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: '4cf5ba798d814c12b7a3d6fffffa7e29'
  location: 'East US'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2025-03-19T08:57:18.3015106Z'
    end_time: '2025-03-19T08:57:19.6294838Z'
    active: false
  }
}

resource sites_united_coach_pdf_processor_name_bacc1bcb8e784bf491562cb6f841c141 'Microsoft.Web/sites/deployments@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: 'bacc1bcb8e784bf491562cb6f841c141'
  location: 'East US'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2025-03-19T08:38:04.5870435Z'
    end_time: '2025-03-19T08:38:05.9195971Z'
    active: false
  }
}

resource sites_united_coach_pdf_processor_name_fd1d34d51dce401c8d613c374a21e862 'Microsoft.Web/sites/deployments@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: 'fd1d34d51dce401c8d613c374a21e862'
  location: 'East US'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2025-03-19T08:41:18.9120021Z'
    end_time: '2025-03-19T08:41:20.2713648Z'
    active: false
  }
}

resource sites_united_coach_pdf_processor_name_ProcessPDF 'Microsoft.Web/sites/functions@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: 'ProcessPDF'
  location: 'East US'
  properties: {
    script_root_path_href: 'https://united-coach-pdf-processor.azurewebsites.net/admin/vfs/site/wwwroot/ProcessPDF/'
    script_href: 'https://united-coach-pdf-processor.azurewebsites.net/admin/vfs/site/wwwroot/ProcessPDF.js'
    config_href: 'https://united-coach-pdf-processor.azurewebsites.net/admin/vfs/site/wwwroot/ProcessPDF/function.json'
    test_data_href: 'https://united-coach-pdf-processor.azurewebsites.net/admin/vfs/data/Functions/sampledata/ProcessPDF.dat'
    href: 'https://united-coach-pdf-processor.azurewebsites.net/admin/functions/ProcessPDF'
    config: {
      bindings: [
        {
          name: 'myBlob'
          type: 'blobTrigger'
          direction: 'in'
          path: 'pdfs/{name}'
          connection: 'STORAGE_CONNECTION_STRING'
        }
      ]
    }
    language: 'node'
    isDisabled: false
  }
}

resource sites_united_coach_pdf_processor_name_sites_united_coach_pdf_processor_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
  parent: sites_united_coach_pdf_processor_name_resource
  name: '${sites_united_coach_pdf_processor_name}.azurewebsites.net'
  location: 'East US'
  properties: {
    siteName: 'united-coach-pdf-processor'
    hostNameType: 'Verified'
  }
}

resource sites_united_coach_web_app_name_sites_united_coach_web_app_name_h3c9dneuf2acgcfv_eastus2_01_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
  parent: sites_united_coach_web_app_name_resource
  name: '${sites_united_coach_web_app_name}-h3c9dneuf2acgcfv.eastus2-01.azurewebsites.net'
  location: 'East US 2'
  properties: {
    siteName: 'united-coach-web-app'
    hostNameType: 'Verified'
  }
}

resource smartdetectoralertrules_failure_anomalies_united_coach_front_end_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_united_coach_front_end_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_united_coach_front_end_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource smartdetectoralertrules_failure_anomalies_united_coach_pdf_processor_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_united_coach_pdf_processor_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_united_coach_pdf_processor_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource smartdetectoralertrules_failure_anomalies_united_coach_web_app_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_united_coach_web_app_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_united_coach_web_app_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource emailServices_united_coach_email_provider_name_azuremanageddomain_donotreply 'microsoft.communication/emailservices/domains/senderusernames@2023-06-01-preview' = {
  name: '${emailServices_united_coach_email_provider_name}/azuremanageddomain/donotreply'
  properties: {
    username: 'DoNotReply'
    displayName: 'DoNotReply'
  }
  dependsOn: [
    emailServices_united_coach_email_provider_name_AzureManagedDomain
    emailServices_united_coach_email_provider_name_resource
  ]
}

resource databaseAccounts_united_coach_cosmos_name_united_coach_container_united_coach_container_id 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-12-01-preview' = {
  parent: databaseAccounts_united_coach_cosmos_name_united_coach_container
  name: 'united-coach-container-id'
  properties: {
    resource: {
      id: 'united-coach-container-id'
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
      partitionKey: {
        paths: [
          '/pageNumber'
        ]
        kind: 'Hash'
        version: 2
      }
      uniqueKeyPolicy: {
        uniqueKeys: [
          {
            paths: [
              '/documentName'
              '/timeStamp'
            ]
          }
        ]
      }
      conflictResolutionPolicy: {
        mode: 'LastWriterWins'
        conflictResolutionPath: '/_ts'
      }
      computedProperties: []
    }
  }
  dependsOn: [
    databaseAccounts_united_coach_cosmos_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_resource 'Microsoft.MachineLearningServices/workspaces@2025-01-01-preview' = {
  name: workspaces_united_coach_ai_hub_name
  location: 'southcentralus'
  tags: {
    __SYSTEM__AzureOpenAI_unitedcoachaih1164957527_aoai: '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/Microsoft.CognitiveServices/accounts/unitedcoachaih1164957527'
    __SYSTEM__AIServices_unitedcoachaih1164957527: '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025/providers/Microsoft.CognitiveServices/accounts/unitedcoachaih1164957527'
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  kind: 'Hub'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: 'United coach ai hub'
    storageAccount: storageAccounts_unitedcoachaih6178051034_externalid
    keyVault: vaults_unite_coach_key_vault_name_resource.id
    applicationInsights: components_united_coach_app_insights_externalid
    hbiWorkspace: false
    managedNetwork: {
      isolationMode: 'Disabled'
    }
    allowRoleAssignmentOnRG: true
    v1LegacyMode: false
    containerRegistry: registries_unitedcoach_externalid
    publicNetworkAccess: 'Enabled'
    ipAllowlist: []
    discoveryUrl: 'https://southcentralus.api.azureml.ms/discovery'
    EnableSoftwareBillOfMaterials: false
    associatedWorkspaces: [
      workspaces_united_coach_llms_name_resource.id
    ]
    workspaceHubConfig: {
      defaultWorkspaceResourceGroup: '/subscriptions/2e620f84-5d37-4a3d-8d06-fff7450c1fdd/resourceGroups/innovation-challenge-march-2025'
    }
    enableDataIsolation: true
    systemDatastoresAuthMode: 'accesskey'
    enableServiceSideCMKEncryption: false
    provisionNetworkNow: false
  }
}

resource workspaces_united_coach_llms_name_resource 'Microsoft.MachineLearningServices/workspaces@2025-01-01-preview' = {
  name: workspaces_united_coach_llms_name
  location: 'southcentralus'
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  kind: 'Project'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: workspaces_united_coach_llms_name
    storageAccount: storageAccounts_unitedcoachaih6178051034_externalid
    keyVault: vaults_unite_coach_key_vault_name_resource.id
    applicationInsights: components_united_coach_app_insights_externalid
    hbiWorkspace: false
    managedNetwork: {
      isolationMode: 'Disabled'
    }
    allowRoleAssignmentOnRG: false
    v1LegacyMode: false
    containerRegistry: registries_unitedcoach_externalid
    publicNetworkAccess: 'Enabled'
    ipAllowlist: []
    discoveryUrl: 'https://southcentralus.api.azureml.ms/discovery'
    EnableSoftwareBillOfMaterials: false
    hubResourceId: workspaces_united_coach_ai_hub_name_resource.id
    enableDataIsolation: true
    systemDatastoresAuthMode: 'accesskey'
    enableServiceSideCMKEncryption: false
  }
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527 'Microsoft.MachineLearningServices/workspaces/connections@2025-01-01-preview' = {
  name: '${workspaces_united_coach_ai_hub_name}/unitedcoachaih1164957527'
  properties: {
    authType: 'ApiKey'
    category: 'AIServices'
    target: 'https://unitedcoachaih1164957527.cognitiveservices.azure.com/'
    useWorkspaceManagedIdentity: true
    isSharedToAll: true
    sharedUserList: []
    peRequirement: 'NotRequired'
    peStatus: 'NotApplicable'
    metadata: {
      ApiType: 'Azure'
      ResourceId: accounts_unitedcoachaih1164957527_name_resource.id
      ApiVersion: '2023-07-01-preview'
      DeploymentApiVersion: '2023-10-01-preview'
    }
  }
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_llms_name_unitedcoachaih1164957527 'Microsoft.MachineLearningServices/workspaces/connections@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/unitedcoachaih1164957527'
  properties: {
    authType: 'ApiKey'
    category: 'AIServices'
    target: 'https://unitedcoachaih1164957527.cognitiveservices.azure.com/'
    useWorkspaceManagedIdentity: true
    isSharedToAll: true
    sharedUserList: []
    peRequirement: 'NotRequired'
    peStatus: 'NotApplicable'
    metadata: {
      ApiType: 'Azure'
      ResourceId: accounts_unitedcoachaih1164957527_name_resource.id
      ApiVersion: '2023-07-01-preview'
      DeploymentApiVersion: '2023-10-01-preview'
    }
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai 'Microsoft.MachineLearningServices/workspaces/connections@2025-01-01-preview' = {
  name: '${workspaces_united_coach_ai_hub_name}/unitedcoachaih1164957527_aoai'
  properties: {
    authType: 'ApiKey'
    category: 'AzureOpenAI'
    target: 'https://unitedcoachaih1164957527.openai.azure.com/'
    useWorkspaceManagedIdentity: true
    isSharedToAll: true
    sharedUserList: []
    peRequirement: 'NotRequired'
    peStatus: 'NotApplicable'
    metadata: {
      ApiType: 'Azure'
      ResourceId: accounts_unitedcoachaih1164957527_name_resource.id
      ApiVersion: '2023-07-01-preview'
      DeploymentApiVersion: '2023-10-01-preview'
    }
  }
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_llms_name_unitedcoachaih1164957527_aoai 'Microsoft.MachineLearningServices/workspaces/connections@2025-01-01-preview' = {
  name: '${workspaces_united_coach_llms_name}/unitedcoachaih1164957527_aoai'
  properties: {
    authType: 'ApiKey'
    category: 'AzureOpenAI'
    target: 'https://unitedcoachaih1164957527.openai.azure.com/'
    useWorkspaceManagedIdentity: true
    isSharedToAll: true
    sharedUserList: []
    peRequirement: 'NotRequired'
    peStatus: 'NotApplicable'
    metadata: {
      ApiType: 'Azure'
      ResourceId: accounts_unitedcoachaih1164957527_name_resource.id
      ApiVersion: '2023-07-01-preview'
      DeploymentApiVersion: '2023-10-01-preview'
    }
  }
  dependsOn: [
    workspaces_united_coach_llms_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_DeepSeek_V3 'Microsoft.MachineLearningServices/workspaces/connections/deployments@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'DeepSeek-V3'
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {}
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_gpt_4o_mini 'Microsoft.MachineLearningServices/workspaces/connections/deployments@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'gpt-4o-mini'
  sku: {
    name: 'GlobalStandard'
    capacity: 250
  }
  properties: {}
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_Phi_4_mini_instruct 'Microsoft.MachineLearningServices/workspaces/connections/deployments@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'Phi-4-mini-instruct'
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {}
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_Phi_4_multimodal_instruct 'Microsoft.MachineLearningServices/workspaces/connections/deployments@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'Phi-4-multimodal-instruct'
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {}
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_text_embedding_3_large 'Microsoft.MachineLearningServices/workspaces/connections/deployments@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'text-embedding-3-large'
  sku: {
    name: 'GlobalStandard'
    capacity: 150
  }
  properties: {}
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_Microsoft_Default 'Microsoft.MachineLearningServices/workspaces/connections/raiPolicies@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'Microsoft.Default'
  properties: {
    type: 'SystemManaged'
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        blocking: true
        enabled: true
        source: 'Completion'
      }
    ]
  }
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai_Microsoft_DefaultV2 'Microsoft.MachineLearningServices/workspaces/connections/raiPolicies@2025-01-01-preview' = {
  parent: workspaces_united_coach_ai_hub_name_unitedcoachaih1164957527_aoai
  name: 'Microsoft.DefaultV2'
  properties: {
    type: 'SystemManaged'
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Jailbreak'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Protected Material Text'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Protected Material Code'
        blocking: false
        enabled: true
        source: 'Completion'
      }
    ]
  }
  dependsOn: [
    workspaces_united_coach_ai_hub_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_audio_data 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'audio-data'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_braille 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'braille'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Container'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_braille_html 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'braille-html'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_gpt_data 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'gpt-data'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Container'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_pdfs 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'pdfs'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Container'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_processed_data 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'processed-data'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Container'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_rag_data 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_united0coach0storage_name_default
  name: 'rag-data'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_united_coach_pdf_processor4611f8c036f9 'Microsoft.Storage/storageAccounts/fileServices/shares@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_united0coach0storage_name_default
  name: 'united-coach-pdf-processor4611f8c036f9'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_azure_webjobs_blobtrigger_cristopher_197329299 'Microsoft.Storage/storageAccounts/queueServices/queues@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_queueServices_storageAccounts_united0coach0storage_name_default
  name: 'azure-webjobs-blobtrigger-cristopher-197329299'
  properties: {
    metadata: {}
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_azure_webjobs_blobtrigger_united_coach_pdf_processor 'Microsoft.Storage/storageAccounts/queueServices/queues@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_queueServices_storageAccounts_united0coach0storage_name_default
  name: 'azure-webjobs-blobtrigger-united-coach-pdf-processor'
  properties: {
    metadata: {}
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_webjobs_blobtrigger_poison 'Microsoft.Storage/storageAccounts/queueServices/queues@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_queueServices_storageAccounts_united0coach0storage_name_default
  name: 'webjobs-blobtrigger-poison'
  properties: {
    metadata: {}
  }
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource storageAccounts_united0coach0storage_name_default_AzureFunctionsDiagnosticEvents202503 'Microsoft.Storage/storageAccounts/tableServices/tables@2024-01-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_united0coach0storage_name_default
  name: 'AzureFunctionsDiagnosticEvents202503'
  properties: {}
  dependsOn: [
    storageAccounts_united0coach0storage_name_resource
  ]
}

resource accounts_united_coach_video_indexer_name_resource 'Microsoft.VideoIndexer/accounts@2025-01-01' = {
  name: accounts_united_coach_video_indexer_name
  location: 'eastus'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    accountId: '594551ac-acdf-4b5f-aba3-6570c88af203'
    storageServices: {
      resourceId: storageAccounts_united0coach0storage_name_resource.id
    }
    openAiServices: {
      resourceId: accounts_united_coach_openai_name_resource.id
    }
  }
}
