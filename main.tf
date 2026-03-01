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
    iothread    = true
    discard     = "on"
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

resource "proxmox_virtual_environment_vm" "vm_web_1" {
  name      = "vm-web-1"
  node_name = "pve"
  vm_id     = 101
  on_boot   = false

  clone {
    vm_id = proxmox_virtual_environment_vm.template_debian.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  disk {
    interface = "scsi0"
    size      = 32
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.3/24"
        gateway = "192.168.1.1"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_web_2" {
  name      = "vm-web-2"
  node_name = "pve"
  vm_id     = 102

  clone {
    vm_id = proxmox_virtual_environment_vm.template_debian.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  disk {
    interface = "scsi0"
    size      = 32
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.4/24"
        gateway = "192.168.1.1"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_web_3" {
  name      = "vm-web-3"
  node_name = "pve"
  vm_id     = 103

  clone {
    vm_id = proxmox_virtual_environment_vm.template_debian.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  disk {
    interface = "scsi0"
    size      = 32
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.5/24"
        gateway = "192.168.1.1"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_web_4" {
  name      = "vm-web-4"
  node_name = "pve"
  vm_id     = 104

  clone {
    vm_id = proxmox_virtual_environment_vm.template_debian.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 4
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 8192
  }

  disk {
    interface = "scsi0"
    size      = 128
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.6/24"
        gateway = "192.168.1.1"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_web_5" {
  name      = "vm-web-5"
  node_name = "pve"
  vm_id     = 105

  clone {
    vm_id = proxmox_virtual_environment_vm.template_debian.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 4
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 8192
  }

  disk {
    interface = "scsi0"
    size      = 128
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.7/24"
        gateway = "192.168.1.1"
      }
    }
  }
}
