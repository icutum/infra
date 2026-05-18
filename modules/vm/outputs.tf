output "cores" {
  value       = var.cores
  description = "Number of CPU cores allocated to the virtual machine"
}

output "memory" {
  value       = var.memory
  description = "Amount of RAM allocated to the virtual machine in MB"
}

output "disk" {
  value       = var.disk
  description = "Disk size for the virtual machine in GB"
}
