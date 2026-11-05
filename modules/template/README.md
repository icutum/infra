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

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}
```

---

## Inputs

| Name              | Type   | Default | Description                                                        |
| ----------------- | ------ | ------- | ------------------------------------------------------------------ |
| name              | string | n/a     | Hostname and display name assigned to the virtual machine          |
| node_name         | string | n/a     | Proxmox node where the virtual machine will be created             |
| vm_id             | number | n/a     | Unique Proxmox VM identifier (must not conflict with existing VMs) |
| datastore_id      | string | local   | Proxmox datastore used to store the cloud image                    |
| image_url         | string | n/a     | URL of the cloud image to download                                 |
| image_file_name   | string | n/a     | File name for the downloaded cloud image                           |
| pre_enrolled_keys | bool   | false   | Whether the pre enrolled keys for secure boot are enabled or not   |
| user_name         | string | n/a     | The default user created in the VM                                 |
| ssh_public_key    | string | n/a     | SSH public key injected via cloud-init                             |

---

## Outputs

| Name                     | Description                                                        |
| ------------------------ | ------------------------------------------------------------------ |
| vm_id                    | The ID of the template VM, used as cloning source                  |
