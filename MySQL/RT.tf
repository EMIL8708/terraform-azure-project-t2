resource "azurerm_route_table" "example" {
  name                          = "example-route-table"
  location                      = azurerm_resource_group.example.location
  resource_group_name           = azurerm_resource_group.example.name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "10.0.1.0/24"
    next_hop_type  = "VnetLocal"
  }
}