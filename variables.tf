# GCP Project Setup
variable "gcp_project_id" {
  description = "GCP Project ID"
}
variable "gcp_region" {
  description = "GCP Region to be used"
}
variable "gcp_zone" {
  description = "GCP Zone to be used"
}
variable "gcp_project_name" {
  description = "GCP Project Name"
}
variable "gcp_service_account" {
  description = "GCP Service Account that will be created, used to create hosting connection in Citrix DaaS"
}

# VM Variables
variable "vmname_prefix" {
  description = "Prefix value to be attached to every VM"
}

variable "vm_timezone" {
  description = "Timezone to be used on the VM https://learn.microsoft.com/en-us/previous-versions/windows/embedded/ms912391(v=winembedded.11)"
}
# Account Variables
variable "username" {
  description = "Local user that will be created to windows VM, this will be added to local administrator group (don't use Administrator)"
}
variable "password" {
  description = "Password of the local  "
}
variable "admin_password" {
  description = "Default Administrator password that will become domain admin"
}

# Domain Variables
variable "domain_fqdn" {
  description = "Domain FQDN that will be created"
}

# Citrix Cloud Variables
variable "citrix_tenant" {
  description = "Citrix Tenant ID, search for it on IAM -> API Access on Citrix Control Plane (AKA Customer ID)"
}
variable "citrix_client_id" {
  description = "Citrix Client ID generated on IAM -> API Access, this will be used to interact with Citrix API"
}
variable "citrix_client_secret" {
  description = "Citrix Secret generated on IAM -> API Access, this will be used to interact with Citrix API"
}
variable "resource_location_name" {
  description = "Resource Location name that will be created on Citrix Control Plane"
}
variable "hosting_connection_name" {
  description = "Hosting Connection Name that will be created on Citrix DaaS"
}
variable "hosting_connection_resoucepool_name" {
  description = "Connection to GCP VPC, fixed to the VDA VPC"
}
variable "deliverygroup_name" {
  description = "Name of the Delivery Group that will be created"
}
variable "machinecatalog_name" {
  description = "Name of the machine catalog that will be created, for Master image is using the VDA deployed on GCP from terraform"
}
variable "vm2deply" {
  description = "Number of the VM that will be created from MCS"
}
variable "workspaceurl" {
  description = "Citrix Cloud URL to be used"
}


# External URL Variables
variable "vda_server_url" {
  description = "URL used to download the VDA"
}
variable "optimizer_url" {
  description = "URL used to download the Citrix Optimizer Tool"
}


########### VM CONFIG ##############

/* if more than 1 VM is needed, just copy/paste the vm block after the default, example:

variable "cloudconnector_vm" {
  description = "Citrix Cloud Connector VM config"
  type        = map(any)
  default = {
    ccc01 = {
      name     = "ccc01"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-a"
      ip       = "192.168.3.3"
      vmimage  = "windows-cloud/windows-2022"
      disktype = "pd-standard"
    }
    ccc02 = {
      name     = "ccc02"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-b"
      ip       = "192.168.3.20"
      vmimage  = "windows-cloud/windows-2022"
      disktype = "pd-standard"
    }
  }
}
NOTE that zone can be changed for HA purpose

vmimage: is pointing to public image on google, using this format will point always to the latest updated image
disktype: pd-standard, pd-balanced, pd-ssd
 */


variable "domaincontroller_vm" {
  description = "Domain Controller VM config"
  type        = map(any)
  default = {
    dom01 = {
      name     = "dom01"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-a"
      ip       = "192.168.3.2"
      vmimage  = "windows-cloud/windows-2022"
      disktype = "pd-balanced"
    }
  }
}

variable "cloudconnector_vm" {
  description = "Citrix Cloud Connector VM config"
  type        = map(any)
  default = {
    ccc01 = {
      name     = "ccc01"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-a"
      ip       = "192.168.3.3"
      vmimage  = "windows-cloud/windows-2022"
      disktype = "pd-standard"
    }
    ccc02 = {
      name     = "ccc02"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-b"
      ip       = "192.168.3.4"
      vmimage  = "windows-cloud/windows-2022"
      disktype = "pd-standard"
    }
  }
}

variable "monitoring_vm" {
  description = "Monitoring VM config"
  type        = map(any)
  default = {
    mon01 = {
      name     = "mon01"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-a"
      ip       = "192.168.3.5"
      vmimage  = "ubuntu-os-cloud/ubuntu-2204-lts"
      disktype = "pd-standard"
      disksize = "40"
    }
  }
}


variable "winvda_vm" {
  description = "Windows VDA VM config"
  default = {
    winvda01 = {
      name     = "winvda01"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-a"
      vmimage  = "windows-cloud/windows-2022"
      disktype = "pd-standard"
    }
  }
}

#######################################################
# GCP VPC and Subnet Setup

variable "vpc_config" {
  description = "GCP network configs"
  type        = map(any)
  default = {
    server = {
      vpc_name    = "ctx-server-vpc"
      subnet_cidr = "192.168.3.0/24"
      subnet_name = "ctx-server-subnet"
    }
    vda = {
      vpc_name    = "ctx-vda-vpc"
      subnet_cidr = "192.168.4.0/24"
      subnet_name = "ctx-vda-subnet"
    }
  }
}

