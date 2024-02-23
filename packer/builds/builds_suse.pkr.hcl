packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

locals {
  time = formatdate("YYYYMMDDhhmmss",timestamp()) # Year Month Day Hour Minute Second with padding.
  patch_version = formatdate("YYYYMMDD",timestamp()) # Year Month Day Hour Minute Second with padding.
}

variable "azure_subscription_id" {
  type    = string
  description = "The subscription id of the service principal."
  default = ""
}

variable "azure_tenant_id" {
  type    = string
  description = "The tenant id of the service principal."
  default = ""
}

variable "azure_client_id" {
  type    = string
  description = "The client id of the service principal."
  default = ""
}

variable "azure_client_secret" {
  type    = string
  description = "The client secret of the service principal."
  default = ""
}

source "azure-arm" "suse" {

  image_publisher = "suse"
  image_offer     = "opensuse-leap-15-5"
  image_sku       = "gen1"

//  Managed images and resource group.
  managed_image_name = "suse-image-${local.time}"
  managed_image_resource_group_name = "packer-rg"
  
  vm_size = "Standard_B1s"
  temp_resource_group_name = "packer-rg-temp-${local.time}"
  location = "East US"
  os_type = "linux"

// // Create a managed image and share it to a gallery
// shared_image_gallery_destination {
//     subscription        = "${var.azure_subscription_id}"
//     gallery_name        = "packer_acg"
//     image_name          = "windows-2019-base"
//     image_version       = "1.0.${local.minor_version}"
//     replication_regions = ["Australia East", "Australia Southeast"]
//     resource_group      = "packer-rg"
//   }

// These are passed in the pipeline.

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}


build {
  sources = ["source.azure-arm.suse"]

  provisioner "shell" {
    inline = ["echo foo"]
}




}
