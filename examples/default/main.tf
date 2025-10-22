terraform {
  required_version = "~> 1.5"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

# Creating a random name
resource "random_string" "service_group" {
  length  = 12
  lower   = true
  special = false
  upper   = false
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "test" {
  source = "../../"

  name         = random_string.service_group.result
  display_name = random_string.service_group.result
}
