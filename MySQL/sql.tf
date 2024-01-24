resource "azurerm_resource_group" "azure-murat" {
  name     = "database-azure-murat"
  location = "West Europe"
}

resource "azurerm_storage_account" "example-murat" {
  name                     = "examplesa-murat"
  resource_group_name      = azurerm_resource_group.example-murat.name
  location                 = azurerm_resource_group.example-murat.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example-murat" {
  name                         = "mssqlserver"
  resource_group_name          = azurerm_resource_group.example-murat.name
  location                     = azurerm_resource_group.example-murat.location
  version                      = "12.0"


  tags = {
    environment = "production"
  }
}