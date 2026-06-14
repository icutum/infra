# Proxmox Template Terraform Module

## Overview

This module provisions a virtual machine template with cloud-init in Proxmox using the `bpg/proxmox` provider.

---

## Usage

```hcl
module "template" {
  source = "./modules/template"

  name      = "template-example"
  node_name = "pve"
  vm_id     = 901

  image_url       = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.raw"
  image_file_name = "debian-13-generic-amd64.raw"
  image_checksum  = "21413b82f1e519f7db60a9290d6929a20aa17baa0b62fde1b283b4afb04cfd70705c1af6c83f0cfd9c0a9a601fdafbd220efd70382b3615aae8a5f7f263f2ea6"

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
| image_checksum           | string | n/a     | Checksum of the cloud image                                        |
| image_checksum_algorithm | string | sha512  | Checksum algorithm                                                 |
| user_name                | string | n/a     | Default user account created via cloud-init                        |
| ssh_public_key           | string | n/a     | SSH public key injected via cloud-init                             |

---

## Outputs

| Name                     | Description                                                        |
| ------------------------ | ------------------------------------------------------------------ |
| vm_id                    | The ID of the template VM, used as cloning source                  |
