# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {

  required_version = ">= 1.0.2"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.3"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = ">= 0.1.1"
    }
  }
}

variable "bw_password" {
  type        = string
  description = "Bitwarden Master Key"
  sensitive   = true
}

variable "bw_client_id" {
  type        = string
  description = "Bitwarden Client ID"
  sensitive   = true
}

variable "bw_client_secret" {
  type        = string
  description = "Bitwarden Client Secret"
  sensitive   = true
}

variable "bw_email" {
  type        = string
  description = "Bitwarden email"
  sensitive   = true
}

provider "bitwarden" {
  master_password = var.bw_password
  client_id       = var.bw_client_id
  client_secret   = var.bw_client_secret
  email           = var.bw_email
  server          = "https://vault.bitwarden.com"
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
}

provider "proxmox" {

  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  # (Optional) Skip TLS Verification
  pm_tls_insecure = true

}
