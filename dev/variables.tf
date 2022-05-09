## Required pre-requisite credentials
variable "vsphere_password" {}
variable "vsphere_username" {}

## Static values for DENTEST vSphere RHEL8
variable "template_params" {
  default = {
    vcpu  = 2
    ram   = 4096
    image = "staticTemplate"
  }
}
variable "vsphere_params" {
  default = {
    server     = "10.0.0.50"
    datacenter = "TEST"
  }
}

## Custom parameters needed for VMs
variable "addr" {
  type        = list(string)
  description = "ordered list of VM IPs"
}
variable "hostname" {
  type        = list(string)
  description = "ordered list of VM hostnames"
}

## Zone defined parameters for VMs
variable "datastore" {
  type        = string
  description = "Datastore cluster name"
}
variable "dns_servers" {
  type        = list(string)
  description = "list of DNS servers"
}
variable "folder" {
  type        = string
  description = "vCenter folder for VMs"
}
variable "gateway" {
  type        = string
  description = "IP gateway for subnet"
}
variable "name_servers" {
  type        = list(string)
  description = "list of domains for DNS lookup, first must be same as local domain"
}
variable "subnet" {
  type        = number
  description = "network subnet mask"
}
variable "vlan_id" {
  type        = string
  description = "vCenter VLAN name"
}
