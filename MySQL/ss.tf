resource "azurerm_subnet" "example" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_lb" "example" {
  name                = "LoadBalancer"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "Public-IP"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "Public-IP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bpepool.id]
  probe_id                       = azurerm_lb_probe.example.id  
}


resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id     = azurerm_lb.example.id
  name                = "BackEndAddressPool"
}



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
  

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "latest"
  }


  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

   
  network_interface {
    name    = "example"
    primary = true
    network_security_group_id = azurerm_network_security_group.example.id

    ip_configuration {
      name      = "subnet3"
      primary   = true
      subnet_id = azurerm_subnet.subnet3.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
    }
  }

}

