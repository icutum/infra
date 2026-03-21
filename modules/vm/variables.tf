variable "name" {
  type        = string
  description = "Hostname and display name assigned to the virtual machine"
}

variable "node_name" {
  type        = string
  description = "Proxmox node where the virtual machine will be created"
}

variable "vm_id" {
  type        = number
  description = "Unique Proxmox VM identifier (must not conflict with existing VMs)"
}

variable "template_id" {
  type        = number
  description = "VM ID of the Proxmox template used as the cloning source"
}

variable "qemu_guest_agent_enabled" {
  type        = bool
  description = "Whether to enable the QEMU guest agent inside the VM"
  default     = true
}

variable "cores" {
  type        = number
  description = "Number of CPU cores allocated to the virtual machine"
  default     = 2
}

variable "memory" {
  type        = number
  description = "Amount of RAM allocated to the virtual machine in MB"
  default     = 2048
}

variable "disk" {
  type        = number
  description = "Disk size for the virtual machine in GB"
  default     = 32
}

variable "ip" {
  type        = string
  description = "Static IPv4 address assigned to the virtual machine (CIDR notation, e.g. 192.168.1.10/24)"
  default     = "dhcp"
}

variable "gateway" {
  type        = string
  description = "Default gateway IPv4 address for the virtual machine"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected into the VM for remote access (cloud-init)"
  sensitive   = true
}
