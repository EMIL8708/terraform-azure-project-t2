resource "random_string" "random" {
  length           = 12
  special          = false
  override_special = "/@£$"
  lower            = true 
  upper            = false 
  numeric          = false
}

resource "azurerm_mysql_server" "example" {
  name                = "example-mysqlserver-mura"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

# Create MySql DataBase
resource "azurerm_mysql_database" "example" {
  name                = var.dbname
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "example" {
  name                = "example-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

data "azurerm_mysql_server" "example" {
  name                = azurerm_mysql_server.example.name
  resource_group_name = azurerm_resource_group.example.name
}