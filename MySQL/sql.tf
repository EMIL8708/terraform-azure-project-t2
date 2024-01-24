resource "azurerm_resource_group" "azure-murat" {
  name     = "database-azure-murat"
  location = "West Europe"
}

resource "azurerm_storage_account" "examplemurat" {
  name                     = "examplesa-murat"
  resource_group_name      = azurerm_resource_group.examplemurat.name
  location                 = azurerm_resource_group.examplemurat.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "examplemurat" {
  name                         = "mssqlserver"
  resource_group_name          = azurerm_resource_group.examplemurat.name
  location                     = azurerm_resource_group.examplemurat.location
  version                      = "12.0"


  tags = {
    environment = "production"
  }
}

