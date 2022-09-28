 ## Forwaring Zone: forward all dns queries of the domain to domain controller
resource "google_dns_managed_zone" "private-forwarding-zone" {
  name        = "${replace(var.domain_fqdn, ".", "-")}-forwarding"
  dns_name    = "${var.domain_fqdn}."
  description = "Private forwarding zone to DC"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = var.vpc_server_selfid
    }
  }
  forwarding_config {
    target_name_servers {
      ipv4_address = var.domaincontroller_vm.dom01.ip
    }
  }
}

 ## DNS Peering Zone for get resolv dns names from VDA VPC
resource "google_dns_managed_zone" "private-peering-zone" {
  name        = "${replace(var.domain_fqdn, ".", "-")}-peering"
  dns_name    = "${var.domain_fqdn}."
  description = "Private Peering"
  visibility  = "private"
  
  private_visibility_config {
    networks {
      network_url = var.vpc_vda_selfid
    }
  }
  peering_config {
    target_network {
      network_url = var.vpc_server_selfid
    }
  }
}