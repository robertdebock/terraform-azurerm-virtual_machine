variable "name" {
  type        = string
  description = "The name of the project. It's used to generate unique values for all kinds of resources."
  default     = "my"
  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 32 && can(regex("^[a-zA-Z0-9_]*", var.name))
    error_message = "Please use a name with at least 1 character, and at most 32 characters."
  }
}

variable "admin_username" {
  type        = string
  description = "Administrator user name for virtual machine."
  default     = "my_admin"
  validation {
    condition     = length(var.admin_username) > 0 && length(var.admin_username) <= 16
    error_message = "Please use a admin_username with at least 1 character, and at most 16 characters."
  }
}

variable "admin_password" {
  type        = string
  description = "Password must meet Azure complexity requirements."
  default     = "my_P@s5-w0rdX"
  sensitive   = true
  validation {
    condition     = length(var.admin_password) >= 8 && can(regex("[a-z]+", var.admin_password)) && can(regex("[A-Z]+", var.admin_password)) && can(regex("[0-9]+", var.admin_password))
    error_message = "Please use a password of 8 characters or more, have at least 1 lower case character, have at least 1 uppper case character, and have at least on digit."
  }
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The location where the resources are applied."
  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "northcentralus", "westus", "southafricanorth", "centralindia", "eastasia", "japaneast", "jioindiawest", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "global", "india", "japan", "uk", "unitedstates", "eastasiastage", "southeastasiastage", "centraluseuap", "eastus2euap", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "swedensouth", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "Please choose an existing location."
  }
}

variable "size" {
  type        = string
  description = "The size of your deployment."
  default     = "medium"
  validation {
    condition     = contains(["micro", "small", "medium", "large", "xlarge"], var.size)
    error_message = "Please choose a valid size: micro, small, medium, large or xlarge."
  }
}
