variable "proxmox_api_url" {
  type        = string
  description = "Base URL of the Proxmox server"
}

variable "proxmox_api_token" {
  type        = string
  description = "API token used to authenticate with Proxmox (Format: USER@REALM!TOKENID=UUID)"
  sensitive   = true
}

variable "proxmox_node_name" {
  type        = string
  description = "Name of the Proxmox node where the VMs will be created"
  default     = "pve"
}

variable "gateway_ip" {
  type        = string
  description = "Default gateway IP address for the VM network"
  default     = "192.168.1.1"
}

variable "vm_user_name" {
  type        = string
  description = "Default user account created via cloud-init on all VMs"
  default     = "mario"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected into the VM for remote access (cloud-init)"
  sensitive   = true
}
