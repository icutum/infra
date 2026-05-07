locals {
  vms_base = {
    vm-web-1 = { vm_id = 101, ip = "192.168.1.3/24", size = "small", agent_enabled = true }
    vm-web-2 = { vm_id = 102, ip = "192.168.1.4/24", size = "small", agent_enabled = true }
    vm-web-3 = { vm_id = 103, ip = "192.168.1.5/24", size = "small", agent_enabled = true }
    vm-web-4 = { vm_id = 104, ip = "192.168.1.6/24", size = "large", agent_enabled = true }
    vm-web-5 = { vm_id = 105, ip = "192.168.1.7/24", size = "large", agent_enabled = true }
  }

  sizes = {
    small = { cores = 2, memory = 4096, disk = 32 }
    large = { cores = 4, memory = 8192, disk = 128 }
  }

  vms = { for name, vm in local.vms_base : name => merge(vm, local.sizes[vm.size]) }
}

module "template" {
  source = "./modules/template"

  name      = "vm-template-debian-13"
  node_name = var.proxmox_node_name
  vm_id     = 901

  image_url       = "https://cdimage.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.raw"
  image_file_name = "debian-13-generic-amd64.raw"

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}

module "vm" {
  source   = "./modules/vm"
  for_each = local.vms

  name                     = each.key
  node_name                = var.proxmox_node_name
  vm_id                    = each.value.vm_id
  template_id              = module.template.vm_id
  qemu_guest_agent_enabled = each.value.agent_enabled

  cores  = each.value.cores
  memory = each.value.memory
  disk   = each.value.disk

  ip      = each.value.ip
  gateway = var.gateway_ip

  user_name      = var.vm_user_name
  ssh_public_key = var.ssh_public_key
}
