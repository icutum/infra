resource "proxmox_download_file" "cloud_image" {
  content_type = "import"
  datastore_id = var.datastore_id
  node_name    = var.node_name
  url          = var.image_url
  file_name    = var.image_file_name
}

resource "proxmox_virtual_environment_vm" "this" {
  name      = var.name
  node_name = var.node_name
  vm_id     = var.vm_id

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
    import_from = proxmox_download_file.cloud_image.id
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
      username = var.user_name
      keys     = [var.ssh_public_key]
    }
  }
}
