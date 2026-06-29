resource "proxmox_virtual_environment_role" "checkmk_role" {
  role_id = "CheckmkMonitoring"

  privileges = [
    "Datastore.Audit",
    "Mapping.Audit",
    "Pool.Audit",
    "SDN.Audit",
    "Sys.Audit",
    "VM.Audit",
    "VM.GuestAgent.Audit",
  ]
}

resource "proxmox_virtual_environment_user" "checkmk_user" {
  user_id  = "checkmk@pve"
  enabled  = true
  password = var.checkmk_password
}

resource "proxmox_acl" "checkmk_acl" {
  user_id   = proxmox_virtual_environment_user.checkmk_user.user_id
  role_id   = proxmox_virtual_environment_role.checkmk_role.role_id
  path      = "/"
  propagate = true
}
