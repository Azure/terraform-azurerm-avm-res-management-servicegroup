terraform {
  required_version = "~> 1.5"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.21"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azapi" {
  # Configuration options
}


provider "azurerm" {
  features {}
  # subscription_id = "your-subscription-id" # Replace with your Azure subscription ID
}

# This ensures we have unique CAF compliant names for our resources.
# Service group is not supported yet
/* module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
} */

# Creating a random name
resource "random_string" "service_group" {
  length  = 12
  lower   = true
  special = false
  upper   = false
}

data "azurerm_client_config" "current" {}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "test" {
  source = "../../"

  service_group_name = random_string.service_group.result
  tenant_id          = data.azurerm_client_config.current.tenant_id
}
