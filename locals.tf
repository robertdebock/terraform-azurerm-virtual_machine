locals {
  resource_group_name                 = "rg_${var.name}"
  virtual_network_name                = "vn_${var.name}"
  subnet_name                         = "s_${var.name}"
  public_ip_name                      = "pi_${var.name}"
  azurerm_network_security_group_name = "nsg_${var.name}"
  network_interface_name              = "ni_${var.name}"
  ip_configuration_name               = "ic_${var.name}"
  virtual_machine_name                = "vm_${var.name}"
  storage_os_disk_name                = "sod_${var.name}"
  computer_name                       = "cn-${var.name}"
  vm_sizes = {
    micro  = "Standard_DS1_v2"
    small  = "Standard_DS2_v2"
    medium = "Standard_DS3_v2"
    large  = "Standard_DS4_v2"
    xlarge = "Standard_DS5_v2
  }
  vm_size = local.vm_sizes[var.size]
}
