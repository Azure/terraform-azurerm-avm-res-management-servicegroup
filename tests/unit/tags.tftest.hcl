mock_provider "azapi" {
  mock_resource "azapi_resource" {
    defaults = {
      tags = {}
    }
  }

  mock_data "azapi_client_config" {
    defaults = {
      tenant_id                = "00000000-0000-0000-0000-000000000001"
      subscription_id          = "00000000-0000-0000-0000-000000000002"
      subscription_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000002"
    }
  }
}

mock_provider "azurerm" {}

variables {
  name             = "test-service-group"
  enable_telemetry = false
}

run "default_tags" {
  command = apply

  providers = {
    azapi   = azapi
    azurerm = azurerm


  }

  assert {
    condition     = var.tags == null && length(azapi_resource.service_group.tags) == 0
    error_message = "Tags must default to null and allow the provider to return the existing tags."
  }

  assert {
    condition     = azapi_resource.service_group.body.properties.parent.resourceId == "/providers/Microsoft.Management/serviceGroups/00000000-0000-0000-0000-000000000001"
    error_message = "The default parent must remain the tenant service group."
  }
  variables {
    location = "eastus"
  }
}

run "custom_tags" {
  command = apply

  providers = {
    azapi   = azapi
    azurerm = azurerm


  }

  variables {
    tags = {
      environment = "test"
      owner       = "module-consumer"
    }
    parent_service_group_id = "parent-group"
    location                = "eastus"
  }

  assert {
    condition     = azapi_resource.service_group.tags == tomap({ environment = "test", owner = "module-consumer" })
    error_message = "Consumer tags must be applied without alteration."
  }

  assert {
    condition     = azapi_resource.service_group.body.properties.parent.resourceId == "/providers/Microsoft.Management/serviceGroups/parent-group"
    error_message = "Explicit parent service groups must remain unchanged."
  }
}
