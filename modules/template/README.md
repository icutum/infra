# Proxmox Template Terraform Module

## Overview

This module provisions a virtual machine template with cloud-init in Proxmox using the `bpg/proxmox` provider.

---

## Requirements

* Terraform >= 1.14.8
* A working Proxmox VE instance
* `bpg/proxmox` provider >= 0.101.1

---

## Usage

```hcl
module "template" {
  source = "./modules/template"

  name      = "template-example"
  node_name = "pve"
  vm_id     = 901

  image_url       = "https://cdimage.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.raw"
  image_file_name = "debian-13-generic-amd64.raw"

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
| datastore_id             | string | local   | Proxmox datastore used to store the cloud image                    |
| image_url                | string | n/a     | URL of the cloud image to download                                 |
| image_file_name          | string | n/a     | File name for the downloaded cloud image                           |
| user_name                | string | n/a     | Default user account created via cloud-init                        |
| ssh_public_key           | string | n/a     | SSH public key injected via cloud-init                             |
