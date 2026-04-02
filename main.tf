locals {
  vms_base = {
    vm-web-1 = { vm_id = 101, ip = "192.168.1.3/24", size = "small", agent_enabled = true }
    vm-web-2 = { vm_id = 102, ip = "192.168.1.4/24", size = "small", agent_enabled = true }
    vm-web-3 = { vm_id = 103, ip = "192.168.1.5/24", size = "small", agent_enabled = true }
    vm-web-4 = { vm_id = 104, ip = "192.168.1.6/24", size = "large", agent_enabled = true }
    vm-web-5 = { vm_id = 105, ip = "192.168.1.7/24", size = "large", agent_enabled = true }
  }

  sizes = {
    small = { cores = 2, memory = 4096, disk = 32 }
    large = { cores = 4, memory = 8192, disk = 128 }
  }

  vms = { for name, vm in local.vms_base : name => merge(vm, local.sizes[vm.size]) }
}

resource "proxmox_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://cdimage.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.raw"
  file_name    = "debian-13-generic-amd64.raw"
}

resource "proxmox_virtual_environment_vm" "template_debian" {
  name      = "template-debian"
  node_name = "pve"
  vm_id     = 901

  template = true
  started  = false

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"

  operating_system {
    type = "l26"
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
  }

  disk {
    import_from = proxmox_download_file.debian_cloud_image.id
    interface   = "scsi0"
    size        = 32
  }

  efi_disk {
    pre_enrolled_keys = true
    type              = "4m"
  }

  vga {
    type = "serial0"
  }

  serial_device {
    device = "socket"
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys     = [var.ssh_public_key]
      username = "mario"
    }
  }
}

module "vm" {
  source   = "./modules/vm"
  for_each = local.vms

  name                     = each.key
  node_name                = var.proxmox_node_name
  vm_id                    = each.value.vm_id
  template_id              = proxmox_virtual_environment_vm.template_debian.id
  qemu_guest_agent_enabled = each.value.agent_enabled

  cores  = each.value.cores
  memory = each.value.memory
  disk   = each.value.disk

  ip      = each.value.ip
  gateway = var.gateway_ip

  ssh_public_key = var.ssh_public_key
}
