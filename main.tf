locals {
  vms_base = {
    110 = { name = "prod-dns-01", ip = "192.168.1.10/24", size = "sm", qemu_guest_agent_enabled = true }
    111 = { name = "prod-dns-02", ip = "192.168.1.11/24", size = "sm", qemu_guest_agent_enabled = true }

    120 = { name = "prod-server-01", ip = "192.168.1.20/24", size = "md", qemu_guest_agent_enabled = true }
    121 = { name = "prod-server-02", ip = "192.168.1.21/24", size = "md", qemu_guest_agent_enabled = true }
    122 = { name = "prod-server-03", ip = "192.168.1.22/24", size = "md", qemu_guest_agent_enabled = true }

    130 = { name = "prod-agent-01", ip = "192.168.1.30/24", size = "lg", qemu_guest_agent_enabled = true }
    131 = { name = "prod-agent-02", ip = "192.168.1.31/24", size = "lg", qemu_guest_agent_enabled = true }
  }

  sizes = {
    sm = { cores = 1, memory = 1024, disk = 32 }
    md = { cores = 2, memory = 4096, disk = 32 }
    lg = { cores = 4, memory = 8192, disk = 128 }
  }

  vms = { for name, vm in local.vms_base : name => merge(vm, local.sizes[vm.size]) }
}

module "template" {
  source = "./modules/template"

  vm_id     = 901
  node_name = var.proxmox_node_name

  name = "template-debian-13"

  image_url       = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.raw"
  image_file_name = "debian-13-generic-amd64.raw"
  image_checksum  = "21413b82f1e519f7db60a9290d6929a20aa17baa0b62fde1b283b4afb04cfd70705c1af6c83f0cfd9c0a9a601fdafbd220efd70382b3615aae8a5f7f263f2ea6"

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}

module "vm" {
  source   = "./modules/vm"
  for_each = local.vms

  vm_id     = each.key
  node_name = var.proxmox_node_name

  name                     = each.value.name
  template_id              = module.template.vm_id
  qemu_guest_agent_enabled = each.value.qemu_guest_agent_enabled

  cores  = each.value.cores
  memory = each.value.memory
  disk   = each.value.disk

  ip      = each.value.ip
  gateway = var.gateway_ip

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}
