data "vsphere_datacenter" "dc" {
  name = var.vsphere_params.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_params.datacenter
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vlan_id
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_params.image
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count            = length(var.hostname)
  name             = var.hostname[count.index]
  folder           = var.folder
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                   = var.template_params.vcpu
  cpu_hot_add_enabled        = true
  memory                     = var.template_params.ram
  memory_hot_add_enabled     = true
  guest_id                   = data.vsphere_virtual_machine.template.guest_id
  scsi_type                  = data.vsphere_virtual_machine.template.scsi_type
  wait_for_guest_net_timeout = 5
  enable_logging             = true
  sata_controller_count      = 1

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  dynamic "disk" {
    for_each = [for _ in range(4) : _]
    content {
      label            = "disk${disk.value}"
      size             = data.vsphere_virtual_machine.template.disks.0.size
      thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
      unit_number      = disk.value
      keep_on_remove   = true
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      dns_server_list = var.dns_servers
      dns_suffix_list = var.name_servers
      ipv4_gateway    = var.gateway
      timeout         = 30
      linux_options {
        host_name = var.hostname[count.index]
        domain    = var.name_servers[0]
      }
      network_interface {
        ipv4_address = var.addr[count.index]
        ipv4_netmask = var.subnet
      }
    }
  }
  cdrom {
    client_device = true
  }
}
