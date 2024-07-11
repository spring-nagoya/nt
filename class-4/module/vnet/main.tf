# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "${var.name_prefix}-vnet"
  address_space       = var.vnet_addr_scope
  location            = var.location
  resource_group_name = var.rg_name
}
