module "azurerm_virtual_machine" {
  source         = "../../"
  name           = "robert"
  admin_password = "S0m3C0mpl3x-P@s5Word"
}

output "public_ip_address" {
  value = module.azurerm_virtual_machine.public_ip_address
}
