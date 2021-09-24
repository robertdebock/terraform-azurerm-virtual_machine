module "azurerm_virtual_machine" {
  source       = "../../"
  name         = "githubrunner'
  cloud_config = "cloud_config"
}

output "public_ip_address" {
  value = module.azurerm_virtual_machine.public_ip_address
}
