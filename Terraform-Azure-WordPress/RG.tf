resource "azurerm_resource_group" "example" {
  name     = "example-resource"
  location = var.location
  tags     = var.tags
}


# Generates a random permutation of alphanumeric characters
resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  numeric  = false
}