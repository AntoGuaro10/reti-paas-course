variable "resource_group" {
  description = "Default rg to use"
  default = "RGPAASCOURSE"
}

variable "subscription" {
  description = "Default subscription to use"
  default = "LGM2"
}

variable "storgaeaccount-tfstate" {
  description = "Defalt storageaccount used for tfstate"
  default = "paasstgaccount1"
}

variable "location" {
  description = "Default location"
  default = "North Europe"
}

variable "vm-password" {
  description = "Admin password for users"
  default = "PaaSc0urs3"
  sensitive = true
}