resource "azurerm_resource_group" "rg" {
  name     = "nt-class"
  location = var.location
}

module "vnet" {
  source = "./module/vnet"

  name_prefix = "nt_class"
  location    = var.location
  rg_name = azurerm_resource_group.rg.name
  vnet_addr_scope = var.vnet_addr_scope
}

module "subnet1" {
  source = "./module/subnet"

  name_prefix = "nt_class_subnet_1"
  location    = var.location
  rg_name = azurerm_resource_group.rg.name
  vnet_name = module.vnet.vnet_name
  subnet = ["10.7.1.0/24"]
}

module "subnet2" {
  source = "./module/subnet"

  name_prefix = "nt_class_subnet_2"
  location    = var.location
  rg_name = azurerm_resource_group.rg.name
  vnet_name = module.vnet.vnet_name
  subnet = ["10.7.2.0/24"]
}


module "storage_account" {
  source = "./module/storage_account"

  location    = var.location
  rg_name = azurerm_resource_group.rg.name
  name_suffix = "ntclass"
}

module "vm20009A" {
  source = "./module/vm"

  vm_name="20009A"
  super_user=var.super_user
  super_user_password=var.super_user_password
  location=var.location
  rg_name=azurerm_resource_group.rg.name
  nic_ids=[module.subnet1.vnet_nic_id]
  size="Standard_B2s"
  storage_account_uri=module.storage_account.storage_account_uri
}

module "vm20009B" {
  source = "./module/vm"

  vm_name="20009B"
  super_user=var.super_user
  super_user_password=var.super_user_password
  location=var.location
  rg_name=azurerm_resource_group.rg.name
  nic_ids=[module.subnet2.vnet_nic_id]
  size="Standard_B2s"
  storage_account_uri=module.storage_account.storage_account_uri
}