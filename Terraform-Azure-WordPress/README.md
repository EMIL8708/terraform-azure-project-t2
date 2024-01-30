Use Terraform to provision an Azure virtual machine scale set running Wordpress.


## Prerequisites

* [Terraform](https://www.terraform.io)
* [Azure subscription](https://azure.microsoft.com/en-us/free)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [GitHub](https://github.com/EMIL8708/terraform-azure-project-t2)

* Amazon AMI bastion
* Login to your Azure Cloud Provider  
* Select Billing Account under hamburger menu 
* Create a Billing Account For ex: in this project we created and used Acoount billing



## How to use

With Terraform and Azure CLI properly configured, you can run:

### `terraform init`

Prepare your working directory.

### `terraform plan`

Generate an execution plan.

### `terraform apply`

Apply changes to Azure cloud.



# Github 

Go to Github and create a repo for your project, dont forget to add .gitignore and README.md files 

This is group project, so add your collaborators into your project with their github names 

After adding them as collaborator, users will be able to add their SSH public keys to github successfully 

Users will be able to clone the project into their locals with git clone command 


# Documentation for vnet.tf and rg.tf files
# RESOURCE GROUP + VNET + SUBNETS

Create a resource group. Configure the Microsoft Azure Provider. 
Steps: 
Create Terraform-Azure-WordPress application Folder with .gitignore and README.md files
Under Terraform-Azure-WordPress create a file  vnet.tf 
Use resource "azurerm_resource_group" "example"  to create resource group
Use resource provider "azurerm" features to create provider resource

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

```
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


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]
}
```

# Documentation for sql.tf file
# MYSQL

```
resource "random_string" "random" {
  length           = 12
  special          = false
  override_special = "/@£$"
  lower            = true 
  upper            = false 
  numeric          = false
}

resource "azurerm_mysql_server" "example" {
  name                = "example-${random_string.random.result}"
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
  end_ip_address      = "0.0.0.0"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "azure" {
  name                = "firewall-aws"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = azurerm_public_ip.example.ip_address
  end_ip_address      = azurerm_public_ip.example.ip_address
}
```

# Documentation for ss.tf file
# SCALE SET

In this project we used Scale Set to make our code more dynamic. Create a file ss.tf 

```
resource "azurerm_lb_probe" "example" {
  loadbalancer_id = azurerm_lb.example.id
  name            = "http-probe"
  port            = 80
  request_path    = null
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_D2S_v3"
  instances           = 1
  admin_username      = "adminuser"
  health_probe_id     = azurerm_lb_probe.example.id
  custom_data         = filebase64("wordpress.sh")
```

# OUTPUT.TF
Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. 
Output values are similar to return values in programming languages.

```
output vnet_id {
    value = azurerm_virtual_network.example.id
}

output rg_id {
    value = azurerm_resource_group.example.id
}

output sql_id {
    value = azurerm_mysql_server.example.id
}

output ss_id {
    value = azurerm_linux_virtual_machine_scale_set.example.id
}
```
