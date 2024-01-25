terraform {
  backend "azurerm" {
        resource_group_name  = "cloud-shell-storage-eastus" #resource resource_group_name created manually 
        storage_account_name = "cs21003200342861b09"     # created manually
        container_name       = "tfstate"
        key                  = "wordpress.tfstate"
    }
}