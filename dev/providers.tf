terraform {
  required_providers {
    vsphere = {
      source  = "registry.terraform.io/hashicorp/vsphere"
      version = "2.1.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_username
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_params.server
  allow_unverified_ssl = true
}
