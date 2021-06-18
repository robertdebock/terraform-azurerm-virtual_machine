module "azurerm_virtual_machine" {
  source = "../../"
}

output "public_ip_address" {
  value = module.azurerm_virtual_machine.public_ip_address
}
