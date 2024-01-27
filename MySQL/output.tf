output vnet_id {
    value = azurerm_virtual_network.example.id
}

output rg_id {
    value = azurerm_resource_group.example.id
}

output sql_id {
    value = azurerm_mysql_server.example.id
}