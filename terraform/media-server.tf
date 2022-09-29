# Proxmox Full-Clone
# ---
# Create a new VM from a clone

variable "bw_item_id" {
  type        = string
  description = "obfuscated id of user password in vault"
  sensitive   = true
}

data "bitwarden_item_login" "ewan_user_password" {
  id = var.bw_item_id
}

resource "proxmox_vm_qemu" "media-server" {

  # VM General Settings
  target_node = "pve"
  vmid        = "210"
  name        = "media-server"
  desc        = "Debian Server for Media Server"

  clone = "debian11-ci-template-tailscale-ssh"

  # VM System Settings
  agent = 1

  # VM CPU Settings
  cores   = 2
  sockets = 2

  # VM Memory Settings
  memory  = 4098
  balloon = 1024

  # VM Cloud-Init Settings
  os_type = "cloud-init"

  ciuser     = "ewan"
  cipassword = data.bitwarden_item_login.ewan_user_password.password
}

#TODO
# output "proxmox_ip_address_default" {
#   description = "Current IP Default"
#   value = proxmox_vm_qemu.test.*.default_ipv4_address
# }
