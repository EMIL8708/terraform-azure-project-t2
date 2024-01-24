# Vnet 
Next we created main.tf configuration file. Vnet is the Virtual Network which will include subnet that will associated with public ip. 

Steps: 
Use resource "azurerm_resource_group" "wordpress" to create the Vnet
Create main.tf file in VNET folder with Makefile, output.tf, provider.tf, variable.tf, .gitignore and README.md files 

resource "azurerm_resource_group" "wordpress" {
  name     = "wordpress-resources"
  location = var.location
  tags     = var.tags
}


resource "azurerm_virtual_network" "wordpress" {
  name                = "wordpress-network"
  resource_group_name = azurerm_resource_group.wordpress.name
  location            = azurerm_resource_group.wordpress.location
  address_space       = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress.name
  address_prefixes     = ["10.0.3.0/24"]
}
