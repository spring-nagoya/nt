variable "vm_name" {
  type = string
}

variable "super_user" {
  type = string
}

variable "super_user_password" {
 type = string 
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "nic_ids" {
  type = list(string)
}

variable "size" {
  type = string
}

variable "storage_account_uri" {
  type = string
}