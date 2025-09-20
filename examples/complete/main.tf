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

## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/avm-utl-regions/azurerm"
  version = "0.9.0"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}

# Creating a random name
resource "random_string" "service_group" {
  length  = 12
  lower   = true
  special = false
  upper   = false
}

data "azurerm_client_config" "current" {}

# This is the module call
module "test" {
  source = "../../"

  service_group_name      = random_string.service_group.result
  tenant_id               = data.azurerm_client_config.current.tenant_id
  enable_telemetry        = true
  parent_service_group_id = data.azurerm_client_config.current.tenant_id
  role_assignments = {
    "test-role" = {
      principal_id               = data.azurerm_client_config.current.object_id
      role_definition_id_or_name = "Contributor"
    }
  }
  service_group_members = {
    "test-resource-group" = {
      targetId = azurerm_resource_group.this.id
    }
  }
}
