output "vm_id" {
  value       = proxmox_virtual_environment_vm.this.id
  description = "The ID of the template VM, used as cloning source"
}
