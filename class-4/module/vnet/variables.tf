variable "name_prefix" {
  type = string
}
variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vnet_addr_scope" {
  type = list(string)
}