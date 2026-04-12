variable "name" {
  type        = string
  description = "Hostname and display name assigned to the virtual machine"
}

variable "node_name" {
  type        = string
  description = "Proxmox node where the template will be created"
}

variable "vm_id" {
  type        = number
  description = "Unique Proxmox VM identifier for the template"
}

variable "datastore_id" {
  type        = string
  description = "Proxmox datastore used to store the cloud image"
  default     = "local"
}

variable "image_url" {
  type        = string
  description = "URL of the cloud image to download"
}

variable "image_file_name" {
  type        = string
  description = "File name for the downloaded cloud image"
}

variable "user_name" {
  type        = string
  description = "Default user account created via cloud-init"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected into the template for remote access (cloud-init)"
  sensitive   = true
}
