# Jellyfin in Docker on Proxmox using Terraform and Ansible   

This is a work in progress IaC project to automate the deployment of my home media server setup.

## Current Functionality 

Currently, it allows you to interact with a [Proxmox](https://www.proxmox.com/en/) instance to deploy a VM using Terraform and the [Proxmox Terraform Provider](https://registry.terraform.io/providers/Telmate/proxmox/2.9.11), run an Ansible playbook to install set up a firewall, install Docker, setup a Jellyfin container, build a custom Caddy image (using xcaddy to allow provision ssl certs via DNS challenges) and deploying Caddy to reverse proxy to the Jellyfin container.

## Roadmap

This project's purpose is try to define my media server setup "end to end" using IaC tools, so as to learn more about them whilst still having fun! 

- [ ] Tie together Terraform and Ansible so that Ansible populates it's inventory using something like [terraform-inventory](https://github.com/nbering/terraform-inventory/) which is a Ansible Dynamic Inventory plugin.
  - [ ] Configure Terraform to return VM ip from QEMU Cloud Agent using Terraform output.
- [ ] Deploy a [Servarr](https://wiki.servarr.com/) stack in Docker passing the stacks network traffic through a Wireguard container. 
- [ ] Add Packer stage to build custom QEMU Template
  - [ ] Maybe move Docker installation to Cloud Init with Packer
