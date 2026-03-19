locals {
  vms = {
    vm-web-1 = {
      id     = 101
      cores  = 2
      memory = 4096
      disk   = 32
      ip     = "192.168.1.3/24"
    }

    vm-web-2 = {
      id     = 102
      cores  = 2
      memory = 4096
      disk   = 32
      ip     = "192.168.1.4/24"
    }

    vm-web-3 = {
      id     = 103
      cores  = 2
      memory = 4096
      disk   = 32
      ip     = "192.168.1.5/24"
    }

    vm-web-4 = {
      id     = 104
      cores  = 4
      memory = 8192
      disk   = 128
      ip     = "192.168.1.6/24"
    }

    vm-web-5 = {
      id     = 105
      cores  = 4
      memory = 8192
      disk   = 128
      ip     = "192.168.1.7/24"
    }
  }
}

resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
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
    import_from = proxmox_virtual_environment_download_file.debian_cloud_image.id
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
  source = "./modules/vm"

  for_each = local.vms

  node_name   = "pve"
  template_id = proxmox_virtual_environment_vm.template_debian.id

  name   = each.key
  vm_id  = each.value.id
  ip     = each.value.ip
  cores  = each.value.cores
  memory = each.value.memory
  disk   = each.value.disk

  gateway        = "192.168.1.1"
  ssh_public_key = var.ssh_public_key
}
