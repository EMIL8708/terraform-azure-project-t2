resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"




  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }


  
    source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

 
  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "subnet3"
      primary   = true
      subnet_id = azurerm_subnet.subnet3.id
    }
  }


    
}

resource "azurerm_virtual_machine_scale_set" "example" {
  name                = "vm-scaleset"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  sku {
    name     = var.vm_sku
    tier     = "Standard"
    capacity = var.instance_count
  }

  identity {
    type = "SystemAssigned"
  }

  os_profile {
    custom_data = file("custom_data.tpl")
    }

  extension {
    name                 = "MSILinuxExtension"
    publisher            = "Microsoft.ManagedIdentity"
    type                 = "ManagedIdentityExtensionForLinux"
    type_handler_version = "1.0"
    settings             = "{\"port\": 50342}"
  }
  # ...
}

output "principal_id" {
  value = azurerm_virtual_machine_scale_set.example.identity[0].principal_id
}