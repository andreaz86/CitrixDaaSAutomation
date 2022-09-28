# GCP Project Setup
variable "gcp_project_id" {}
variable "gcp_region" {}
variable "gcp_zone" {}
variable "gcp_project_name" {}
variable "gcp_service_account" {}

# VM Variables
variable "vmname_prefix" {}

# Account Variables
variable "username" {}
variable "password" {}
variable "admin_password" {}

# Domain Variables
variable "domain_fqdn" {}

# Citrix Cloud Variables
variable "citrix_tenant" {}
variable "citrix_client_id" {}
variable "citrix_client_secret" {}
variable "resource_location_name" {}
variable "hosting_connection_name" {}
variable "hosting_connection_resoucepool_name" {}
variable "deliverygroup_name" {}
variable "machinecatalog_name" {}
variable "vm2deply" {}
variable "workspaceurl" {}
variable "adcgwurl" {}

# External URL Variables
variable "vda_server_url" {}
variable "optimizer_url" {}


########### VM CONFIG ##############

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
  }
}

variable "storefront_vm" {
  description = "Citrix Storefront VM config"
  type        = map(any)
  default = {
    stf01 = {
      name     = "stf01"
      vmtype   = "n2-standard-2"
      zone     = "europe-west4-a"
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
      ip       = "192.168.3.6"
      vmimage  = "ubuntu-os-cloud/ubuntu-2204-lts"
      disktype = "pd-standard"
      disksize = "40"
    }
  }
}

variable "adc_vm" {
  description = "Citrix ADC "
  default = {
    adc01 = {
      name      = "adc01"
      vmtype    = "n2-standard-2"
      zone      = "europe-west4-a"
      server_ip = "192.168.3.7"
      snip      = "192.168.3.8"
      vmimage   = "projects/citrix-master-project/global/images/citrix-adc-vpx-byol-13-1-9-60"
      disktype  = "pd-standard"
    }
    adc02 = {
      name      = "adc02"
      vmtype    = "n2-standard-2"
      zone      = "europe-west4-b"
      server_ip = "192.168.3.9"
      snip      = "192.168.3.10"
      vmimage   = "projects/citrix-master-project/global/images/citrix-adc-vpx-byol-13-1-9-60"
      disktype  = "pd-standard"
    }
  }
}


variable "adm_vm" {
  description = "Citrix ADM Agent "
  default = {
    adm01 = {
      name      = "adm01"
      vmtype    = "n2-standard-2"
      zone      = "europe-west4-a"
      server_ip = "192.168.3.11"
      vmimage   = "projects/citrix-master-project/global/images/citrix-adm-agent-13-1-28-21"
      disktype  = "pd-standard"
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

variable "lin_vda_name" {
  description = "Linux VDA VM name"
  default     = "linvda01"
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

