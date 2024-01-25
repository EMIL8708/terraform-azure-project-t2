resource "azurerm_lb" "example" {
  name                = "example-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "Public-IP"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id = azurerm_lb.example.id
  name            = "BackEndAddressPool"
}


resource "azurerm_lb_probe" "example" {
  loadbalancer_id     = azurerm_lb.example.id
  name                = "example-probe"
  port                = var.application_port
}

