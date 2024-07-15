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
  rg_name = azurerm_resource_group.rg.name
  vnet_name = module.vnet.vnet_name
  subnet = ["10.7.1.0/24"]
}

module "subnet2" {
  source = "./module/subnet"

  name_prefix = "nt_class_subnet_2"
  rg_name = azurerm_resource_group.rg.name
  vnet_name = module.vnet.vnet_name
  subnet = ["10.7.2.0/24"]
}

module "subnet1_nic1" {
  source = "./module/nic"

  name_prefix = "nt_class_subnet_1_nic_1"
  rg_name = azurerm_resource_group.rg.name
  subnet_id = module.subnet1.subnet_id
  location = var.location
}

module "subnet1_nic2" {
  source = "./module/nic"

  name_prefix = "nt_class_subnet_1_nic_2"
  rg_name = azurerm_resource_group.rg.name
  subnet_id = module.subnet1.subnet_id
  location = var.location
}

module "subnet2_nic1" {
  source = "./module/nic"

  name_prefix = "nt_class_subnet_2_nic_1"
  rg_name = azurerm_resource_group.rg.name
  subnet_id = module.subnet2.subnet_id
  location = var.location
}

module "storage_account" {
  source = "./module/storage_account"

  location    = var.location
  rg_name = azurerm_resource_group.rg.name
  name_suffix = "ntclass"
}

module "vm20009A" {
  source = "./module/vm-win"

  vm_name="20009A"
  super_user=var.super_user
  super_user_password=var.super_user_password
  location=var.location
  rg_name=azurerm_resource_group.rg.name
  nic_ids=[module.subnet1_nic1.vnet_nic_id]
  size="Standard_B2s"
}

module "vm20009B" {
  source = "./module/vm-win"

  vm_name="20009B"
  super_user=var.super_user
  super_user_password=var.super_user_password
  location=var.location
  rg_name=azurerm_resource_group.rg.name
  nic_ids=[module.subnet2_nic1.vnet_nic_id]
  size="Standard_B2s"
}

module "vm20009C" {
  source = "./module/vm-linux"

  vm_name="20009C"
  super_user=var.super_user
  super_user_password=var.super_user_password
  location=var.location
  rg_name=azurerm_resource_group.rg.name
  nic_ids=[module.subnet1_nic2.vnet_nic_id]
  size="Standard_B2s"
  
  publisher = "Oracle"
  offer     = "Oracle-Linux"
  sku       = "ol92-lvm"
  os-version   = "latest"
}
