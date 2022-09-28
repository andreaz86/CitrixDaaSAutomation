 ## CREATE VPC

resource "google_compute_network" "vpc_server" {
  name                    = var.vpc_config.server.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_vda" {
  name                    = var.vpc_config.vda.vpc_name
  auto_create_subnetworks = false
}

 ## Create Subnetwork

resource "google_compute_subnetwork" "server_subnet" {
  name          = var.vpc_config.server.subnet_name
  ip_cidr_range = var.vpc_config.server.subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.vpc_server.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "vda_subnet" {
  name          = var.vpc_config.vda.subnet_name
  ip_cidr_range = var.vpc_config.vda.subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.vpc_vda.self_link
  private_ip_google_access = true
}

 ## PRIVATE IP

  resource "google_compute_address" "cloudconnector_internal_ip" {
  for_each = var.cloudconnector_vm
  name         = "${each.value.name}-ip"
  subnetwork   = google_compute_subnetwork.server_subnet.self_link
  address_type = "INTERNAL"
  address      = each.value.ip
  region       = var.gcp_region
}

resource "google_compute_address" "domaincontroller_internal_ip" {
  for_each = var.domaincontroller_vm
  name         = "${each.value.name}-ip"
  subnetwork   = google_compute_subnetwork.server_subnet.self_link
  address_type = "INTERNAL"
  address      = each.value.ip
  region       = var.gcp_region
}


resource "google_compute_address" "monitoring_internal_ip" {
  for_each = var.monitoring_vm
  name         = "${each.value.name}-ip"
  subnetwork   = google_compute_subnetwork.server_subnet.self_link
  address_type = "INTERNAL"
  address      = each.value.ip
  region       = var.gcp_region
} 

 ## VPC Peering

resource "google_compute_network_peering" "vda_server_peering" {
  name         = "peering1"
  network      = google_compute_network.vpc_vda.self_link
  peer_network = google_compute_network.vpc_server.self_link
}

resource "google_compute_network_peering" "server_vda_peering" {
  name         = "peering2"
  network      = google_compute_network.vpc_server.self_link
  peer_network = google_compute_network.vpc_vda.self_link
}

## get current public IP of the workstation to create firewall rules
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}