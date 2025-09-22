provider "azurerm" {
  features {
  }
  subscription_id                 = "c3b8f4b9-4b0d-44ac-a724-de32a897990e"
  environment                     = "public"
  use_msi                         = false
  use_cli                         = true
  use_oidc                        = false
  resource_provider_registrations = "none"
}
