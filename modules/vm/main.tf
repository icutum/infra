resource "proxmox_virtual_environment_vm" "this" {
  name      = var.name
  node_name = var.node_name
  vm_id     = var.vm_id

  clone {
    vm_id = var.template_id
  }

  agent {
    enabled = var.qemu_guest_agent_enabled
  }

  cpu {
    cores = var.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  disk {
    interface = "scsi0"
    size      = var.disk
  }

  network_device {
    firewall = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip
        gateway = var.gateway
      }
    }

    user_account {
      username = "mario"
      keys     = [var.ssh_public_key]
    }
  }
}
