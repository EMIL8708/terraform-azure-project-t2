terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = "cloud-shell-storage-eastus" #resource resource_group_name created manually 
        storage_account_name = "cs2100320034430688d"     # created manually
        container_name       = "tfstate"
        key                  = "wordpress.tfstate"
    }
}