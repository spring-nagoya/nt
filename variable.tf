variable "location" {
  type = string
}
variable "vnet_addr_scope" {
  type = list(string)
}

variable "super_user" {
  type = string
}

variable "super_user_password" {
  type = string
}