resource "azurerm_network_watcher" "res-0" {
  location            = "northeurope"
  name                = "NetworkWatcher_northeurope"
  resource_group_name = "NetworkWatcherRG"
}
resource "azurerm_ai_services" "res-1" {
  custom_subdomain_name = "ai-aktyvas5797ai312811327532"
  location              = "eastus2"
  name                  = "ai-aktyvas5797ai312811327532"
  resource_group_name   = "rg-aktyvas-lang"
  sku_name              = "S0"
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_ai_foundry" "res-3" {
  friendly_name       = "aktyvas-5797_ai"
  key_vault_id        = "/subscriptions/c3b8f4b9-4b0d-44ac-a724-de32a897990e/resourceGroups/rg-aktyvas-lang/providers/Microsoft.KeyVault/vaults/kv-aktyvas5312811327532"
  location            = "eastus2"
  name                = "aktyvas-5797_ai"
  resource_group_name = "rg-aktyvas-lang"
  storage_account_id  = azurerm_storage_account.res-5.id
  tags = {
    __SYSTEM__AIServices_ai-aktyvas5797ai312811327532       = azurerm_ai_services.res-1.id
    __SYSTEM__AzureOpenAI_ai-aktyvas5797ai312811327532_aoai = azurerm_ai_services.res-1.id
  }
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_ai_foundry_project" "res-4" {
  ai_services_hub_id = azurerm_ai_foundry.res-3.id
  friendly_name      = "aktyvas-lang"
  location           = "eastus2"
  name               = "aktyvas-lang"
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_storage_account" "res-5" {
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  location                        = "eastus2"
  name                            = "staktyvas579312811327532"
  resource_group_name             = "rg-aktyvas-lang"
}
resource "azurerm_data_factory" "res-6" {
  location            = "northeurope"
  name                = "adf-integrate-service"
  resource_group_name = "rg_adf"
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_bot_service_azure_bot" "res-7" {
  endpoint                      = "https://langqna-bot-e747.azurewebsites.net/api/messages"
  location                      = "global"
  microsoft_app_id              = "86440192-6e28-4e14-a972-8a32a0f76df4"
  microsoft_app_msi_id          = azurerm_user_assigned_identity.res-10.id
  microsoft_app_tenant_id       = "227b1a00-a960-41d4-9f53-afda047720ce"
  microsoft_app_type            = "UserAssignedMSI"
  name                          = "langqna-bot6"
  public_network_access_enabled = false
  resource_group_name           = "rg_ai"
  sku                           = "F0"
  tags = {
    WebAppLinked = "true"
  }
}
resource "azurerm_cognitive_account" "res-8" {
  custom_subdomain_name = "acuradoc"
  kind                  = "FormRecognizer"
  location              = "northeurope"
  name                  = "acuradoc"
  resource_group_name   = "rg_ai"
  sku_name              = "F0"
  network_acls {
    default_action = "Allow"
  }
}
resource "azurerm_cognitive_account" "res-9" {
  custom_subdomain_name = "langqnalaivas"
  kind                  = "TextAnalytics"
  location              = "northeurope"
  name                  = "langqnaLaivas"
  resource_group_name   = "rg_ai"
  sku_name              = "F0"
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_user_assigned_identity" "res-10" {
  location            = "northeurope"
  name                = "langqna-bot6"
  resource_group_name = "rg_ai"
}
resource "azurerm_service_plan" "res-11" {
  location            = "northeurope"
  name                = "bot-win-as"
  os_type             = "Windows"
  resource_group_name = "rg_ai"
  sku_name            = "F1"
}
resource "azurerm_windows_web_app" "res-12" {
  app_settings = {
    DisplayPreciseAnswerOnly = "false"
    EnablePreciseAnswer      = "true"
    LanguageEndpointHostName = "https://langqna.cognitiveservices.azure.com"
    LanguageEndpointKey      = "6xdXGBZiWZcKOKgwqBrRzOOzvLPcCDOYWe9H97TCMQB0m4thH7axJQQJ99BHACYeBjFXJ3w3AAAaACOGSQnO"
    MicrosoftAppId           = "86440192-6e28-4e14-a972-8a32a0f76df4"
    MicrosoftAppTenantId     = "227b1a00-a960-41d4-9f53-afda047720ce"
    MicrosoftAppType         = "UserAssignedMSI"
    ProjectName              = "langqa2"
  }
  client_affinity_enabled = true
  location                = "northeurope"
  name                    = "langqna-bot-e747"
  resource_group_name     = "rg_ai"
  service_plan_id         = azurerm_service_plan.res-11.id
  identity {
    identity_ids = [azurerm_user_assigned_identity.res-10.id]
    type         = "UserAssigned"
  }
  site_config {
    always_on                         = false
    ftps_state                        = "FtpsOnly"
    ip_restriction_default_action     = "Allow"
    scm_ip_restriction_default_action = "Allow"
    websockets_enabled                = true
    cors {
      allowed_origins = ["https://botservice-ms.hosting.portal.azure.net", "https://botservice.hosting.portal.azure.net", "https://hosting.onecloud.azure-test.net/", "https://ms.portal.azure.com"]
    }
  }
}
resource "azurerm_service_plan" "res-13" {
  location            = "northeurope"
  name                = "langqna-as"
  os_type             = "Linux"
  resource_group_name = "rg_bot"
  sku_name            = "B1"
}
resource "azurerm_monitor_action_group" "res-14" {
  name                = "ag1"
  resource_group_name = "rg_budget"
  short_name          = "ag1"
  email_receiver {
    email_address = "lazydbausa@gmail.com"
    name          = "notify_lazydbausa_-EmailAction-"
  }
}
resource "azurerm_key_vault" "res-15" {
  enable_rbac_authorization = true
  location                  = "northeurope"
  name                      = "azurekvservice2"
  resource_group_name       = "rg_kv"
  sku_name                  = "standard"
  tenant_id                 = "227b1a00-a960-41d4-9f53-afda047720ce"
}
resource "azurerm_cognitive_account" "res-16" {
  custom_question_answering_search_service_id = azurerm_search_service.res-17.id
  custom_subdomain_name                       = "langqna"
  kind                                        = "TextAnalytics"
  location                                    = "eastus"
  name                                        = "langqna"
  resource_group_name                         = "rg_qna"
  sku_name                                    = "F0"
  identity {
    type = "SystemAssigned"
  }
  network_acls {
    default_action = "Allow"
  }
}
resource "azurerm_search_service" "res-17" {
  location            = "eastus"
  name                = "langqna-as67hxeqctwooiw"
  resource_group_name = "rg_qna"
  sku                 = "free"
}
resource "azurerm_user_assigned_identity" "res-18" {
  location            = "eastus"
  name                = "id_sql"
  resource_group_name = "rg_sql"
}
resource "azurerm_mssql_server" "res-19" {
  administrator_login = "sqladmin"
  location            = "northeurope"
  name                = "flex2"
  resource_group_name = "rg_sql"
  version             = "12.0"
  azuread_administrator {
    login_username = "aktyvas_gmail.com#EXT#@aktyvasgmail.onmicrosoft.com"
    object_id      = "b16720cd-44b0-4224-a0d4-f860eba18925"
  }
  administrator_login_password = "Labadiena1!"
}
resource "azurerm_mssql_database" "res-20" {
  name                 = "flex2"
  server_id            = azurerm_mssql_server.res-19.id
  storage_account_type = "Local"
}
resource "azurerm_mssql_database" "res-21" {
  name                 = "flexdb"
  server_id            = azurerm_mssql_server.res-19.id
  storage_account_type = "Local"
}
resource "azurerm_resource_group" "res-22" {
  name     = "rg-terraform-example"
  location            = "eastus"
}
resource "azurerm_storage_account" "res-23" {
  name                     = "storacctexample123"
  resource_group_name      = "rg-terraform-example"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
