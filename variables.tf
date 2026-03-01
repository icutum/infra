variable "proxmox_api_url" {
  type        = string
  description = "The endpoint of the Proxmox API"
}

variable "proxmox_api_token" {
  type        = string
  description = "The combination of user, realm and token ID to access the Proxmox API (Format: USER@REALM!TOKENID=UUID)"
  sensitive   = true
}

variable "ssh_public_key" {
  type = string
  description = "The public SSH key for accessing the VMs"
  sensitive = true
}
