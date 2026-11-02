locals {
  templates = {
    901 = { name = "template-debian-13", url = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.raw", file_name = "debian-13-amd64.raw", compression = null }
    902 = { name = "template-talos-1.14.5", url = "https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.14.5/nocloud-amd64.raw.zst", file_name = "talos-1.14.5-amd64.raw", compression = "zst" }
  }

  vms = {
    110 = { name = "prod-dns-01", ip = "192.168.1.10/24", size = "sm", template_id = 901 }
    111 = { name = "prod-dns-02", ip = "192.168.1.11/24", size = "sm", template_id = 901 }

    120 = { name = "prod-server-01", ip = "192.168.1.20/24", size = "md", template_id = 901 }
    121 = { name = "prod-server-02", ip = "192.168.1.21/24", size = "md", template_id = 901 }
    122 = { name = "prod-server-03", ip = "192.168.1.22/24", size = "md", template_id = 901 }

    130 = { name = "prod-agent-01", ip = "192.168.1.30/24", size = "lg", template_id = 901 }
    131 = { name = "prod-agent-02", ip = "192.168.1.31/24", size = "lg", template_id = 901 }
  }

  sizes = {
    sm = { cores = 1, memory = 1024, disk = 32 }
    md = { cores = 2, memory = 4096, disk = 32 }
    lg = { cores = 4, memory = 8192, disk = 128 }
  }
}

module "template" {
  source   = "./modules/template"
  for_each = local.templates

  vm_id     = each.key
  node_name = var.proxmox_node_name

  name = each.value.name

  image_url               = each.value.url
  image_file_name         = each.value.file_name
  decompression_algorithm = each.value.compression

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}

module "vm" {
  source   = "./modules/vm"
  for_each = local.vms

  vm_id     = each.key
  node_name = var.proxmox_node_name

  name        = each.value.name
  template_id = each.value.template_id

  cores  = local.sizes[each.value.size].cores
  memory = local.sizes[each.value.size].memory
  disk   = local.sizes[each.value.size].disk

  ip      = each.value.ip
  gateway = var.gateway_ip

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}
