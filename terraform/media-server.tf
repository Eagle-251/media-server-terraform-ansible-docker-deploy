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

  # VM Advanced General Settings
  # onboot = true

  # VM OS Settings
  clone = "debian11-ci-template-tailscale-ssh"
  # full_clone = false

  # VM System Settings
  agent = 1

  # VM CPU Settings
  cores   = 2
  sockets = 2
  # cpu     = "host"

  # VM Memory Settings
  memory  = 4098
  balloon = 1024

  # VM Network Settings
  # network {
  #   bridge  = "vmbr0"
  #   model   = "virtio"
  #   macaddr = "52:A1:9D:2C:E1:C2"
  # }
  # disk {
  #   size    = "70G"
  #   type    = "scsi"
  #   storage = "local-lvm"
  # }

  # VM Cloud-Init Settings
  os_type = "cloud-init"

  # (Optional) IP Address and Gateway
  # ipconfig0 = "ip=192.168.1.102/32,gw=192.168.1.1"

  # (Optional) Default User
  ciuser     = "ewan"
  cipassword = data.bitwarden_item_login.ewan_user_password.password
  # cicustom   = "user=snippets:snippets/ubuntu-tailscale-docker.yml"
  # cloudinit_cdrom_storage = "local-lvm"

  # (Optional) Add your SSH KEY
  # sshkeys = <<EOF
  #   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJMnq1UL0GsMFPHPr3D5GY81YUVM5c3YX64jhbW4Y6BS openpgp:0xDB92184E
  #   EOF
  # provisioner "remote-exec" {
  #   inline = [
  #     "ip a"
  #   ]
  # }
}

#TODO
# output "proxmox_ip_address_default" {
#   description = "Current IP Default"
#   value = proxmox_vm_qemu.test.*.default_ipv4_address
# }
