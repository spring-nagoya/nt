resource "azurerm_windows_virtual_machine" "main" {
  name                  = var.vm_name
  admin_username        = var.super_user
  admin_password        = var.super_user_password
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = var.nic_ids
  size                  = var.size

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }


  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}
