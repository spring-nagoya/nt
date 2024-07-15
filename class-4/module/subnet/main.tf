

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "${var.name_prefix}-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet
}
