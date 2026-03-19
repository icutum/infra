variable "proxmox_api_url" {
  type        = string
  description = "Base URL of the Proxmox server"
}

variable "proxmox_api_token" {
  type        = string
  description = "API token used to authenticate with Proxmox (Format: USER@REALM!TOKENID=UUID)"
  sensitive   = true
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected into the VM for remote access (cloud-init)"
  sensitive   = true
}
