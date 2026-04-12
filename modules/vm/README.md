# Proxmox VM Terraform Module

## Overview

This module provisions a virtual machine in Proxmox using the `bpg/proxmox` provider.
It clones a VM from an existing template and configures compute resources, disk, networking, and cloud-init settings.

---

## Requirements

* Terraform >= 1.14.8
* A working Proxmox VE instance
* `bpg/proxmox` provider >= 0.101.1

---

## Usage

```hcl
module "vm" {
  source = "./modules/vm"

  name                     = "vm-example"
  node_name                = "pve"
  vm_id                    = 101
  template_id              = 901
  qemu_guest_agent_enabled = false

  cores          = 2
  memory         = 4096
  disk           = 32

  ip             = "192.168.1.101/24"
  gateway        = "192.168.1.1"

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}
```

---

## Inputs

| Name                     | Type   | Default | Description                                                        |
| ------------------------ | ------ | ------- | ------------------------------------------------------------------ |
| name                     | string | n/a     | Hostname and display name assigned to the virtual machine          |
| node_name                | string | n/a     | Proxmox node where the virtual machine will be created             |
| vm_id                    | number | n/a     | Unique Proxmox VM identifier (must not conflict with existing VMs) |
| template_id              | number | n/a     | VM ID of the Proxmox template used as the cloning source           |
| qemu_guest_agent_enabled | bool   | true    | Whether to enable the QEMU guest agent inside the VM               |
| cores                    | number | 2       | Number of CPU cores allocated to the virtual machine               |
| memory                   | number | 2048    | Amount of RAM allocated to the virtual machine in MB               |
| disk                     | number | 32      | Disk size for the virtual machine in GB                            |
| ip                       | string | dhcp    | Static IPv4 address in CIDR format (e.g. 192.168.1.101/24)         |
| gateway                  | string | n/a     | Default gateway IPv4 address                                       |
| user_name                | string | n/a     | Default user account created via cloud-init                        |
| ssh_public_key           | string | n/a     | SSH public key injected via cloud-init                             |
