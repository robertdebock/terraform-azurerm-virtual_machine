# Add a resource group..
resource "azurerm_resource_group" "default" {
  name     = local.resource_group_name
  location = var.location
}

# Create a virtual network.
resource "azurerm_virtual_network" "default" {
  name                = local.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
}

# Create subnet
resource "azurerm_subnet" "default" {
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IP
resource "azurerm_public_ip" "default" {
  name                = local.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "default" {
  name                = local.azurerm_network_security_group_name
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "default" {
  name                = local.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name

  ip_configuration {
    name                          = local.ip_configuration_name
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.default.id
  }
}

data "template_file" "default" {
  count    = var.cloud_config == "" ? 0 : 1
  template = file("${var.cloud_config}")
}

data "template_cloudinit_config" "default" {
  count         = var.cloud_config == "" ? 0 : 1
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.default[count.index].rendered}"
  }
}

# Create a Linux virtual machine
resource "azurerm_linux_virtual_machine" "default" {
  count                           = 1
  name                            = local.virtual_machine_name
  computer_name                   = var.name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.default.name
  network_interface_ids           = [azurerm_network_interface.default.id]
  size                            = local.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data                     = try(data.template_cloudinit_config.default[count.index].rendered, null)

  os_disk {
    name                 = local.storage_os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

data "azurerm_public_ip" "default" {
  count               = 1
  name                = azurerm_public_ip.default.name
  resource_group_name = azurerm_linux_virtual_machine.default[count.index].resource_group_name
  depends_on          = [azurerm_linux_virtual_machine.default]
}
