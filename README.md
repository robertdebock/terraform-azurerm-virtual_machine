# Terraform module to create a virtual machine

## Usage

You can use all default variables:

```hcl
module "virtual_machine" {
  source  = "robertdebock/virtual_machine/azurerm"
  version = "1.0.0"
}
```

Likely you want to override some values:

```hcl
module "virtual_machine" {
  source         = "robertdebock/virtual_machine/azurerm"
  version        = "1.0.0"
  name           = "customer-x"
  admin_password = "S0m3C0mpl3x-P@s5Word"
}
```

This Terraform module creates multiple resources to support a `azurerm_virtual_machine`.

- `azurerm_resource_group`
- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_public_ip`
- `azurerm_network_security_group`
- `azurerm_network_interface`
- `azurerm_virtual_machine`

## Input

The input the module requires: (all optional)

|variable        |type  |default        |
|----------------|------|---------------|
|`name`          |string|"my"           |
|`admin_username`|string|"my_admin"     |
|`admin_password`|string|"my_P@s5-w0rdX"|
|`location`      |string|"westeurope"   |
|`size`          |string|"medium"       |

### Sizes

Sizes are mapping (in `locals.tf`) to the SKU. Possible values are:

- "micro" (`Standard_DS1_v2`)
- "small" (`Standard_DS2_v2`)
- "medium" (`Standard_DS3_v2`)
- "large" (`Standard_DS4_v2`)
- "xlarge" (`Standard_DS5_v2`)

The specs for the sizes can be found on [MicroSofts documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/dv2-dsv2-series#dv2-series).

### Locations

Valid values (listed in `variables.tf`) are:

- "asia"
- "asiapacific"
- "australia"
- "australiacentral"
- "australiacentral2"
- "australiaeast"
- "australiasoutheast"
- "brazil"
- "brazilsouth"
- "brazilsoutheast"
- "canada"
- "canadacentral"
- "canadaeast"
- "centralindia"
- "centralus"
- "centraluseuap"
- "centralusstage"
- "eastasia"
- "eastasiastage"
- "eastus"
- "eastus2"
- "eastus2euap"
- "eastus2stage"
- "eastusstage"
- "europe"
- "francecentral"
- "francesouth"
- "germanynorth"
- "germanywestcentral"
- "global"
- "india"
- "japan"
- "japaneast"
- "japanwest"
- "jioindiacentral"
- "jioindiawest"
- "koreacentral"
- "koreasouth"
- "northcentralus"
- "northcentralusstage"
- "northeurope"
- "norwayeast"
- "norwaywest"
- "southafricanorth"
- "southafricawest"
- "southcentralus"
- "southcentralusstage"
- "southeastasia"
- "southeastasiastage"
- "southindia"
- "swedencentral"
- "swedensouth"
- "switzerlandnorth"
- "switzerlandwest"
- "uaecentral"
- "uaenorth"
- "uk"
- "uksouth"
- "ukwest"
- "unitedstates"
- "westcentralus"
- "westeurope"
- "westindia"
- "westus"
- "westus2"
- "westus2stage"
- "westus3"
- "westusstage"    
