 # Firewall rules applied to VDA VPC
 # ["${chomp(data.http.myip.response_body)}/32"] can be replaced by [0.0.0.0/0] to allow from anywhere

resource "google_compute_firewall" "default-allow-vda-localnet" {
  name    = "default-allow-vda-localnet"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "all"
  }
  source_ranges = [var.vpc_config.vda.subnet_cidr]
}

resource "google_compute_firewall" "allow-rdp-vda" {
  name    = "allow-vda-rdp"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  target_tags   = ["rdp"]
}

resource "google_compute_firewall" "allow-ssh-vda" {
  name    = "allow-vda-ssh"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "allow-winrm-vda" {
  name    = "allow-vda-winrm"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "tcp"
    ports    = ["5985","5986"]
  }
  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  target_tags   = ["vda"]
}

resource "google_compute_firewall" "allow-80-from-cc" {
  name    = "allow-80-from-cc"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = [var.vpc_config.server.subnet_cidr]
  target_tags = ["vda"]
}

resource "google_compute_firewall" "allow-vda-fromserver" {
  name    = "allow-vda-from-server"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "all"
  }
  source_ranges = [var.vpc_config.server.subnet_cidr]
}

resource "google_compute_firewall" "allow-dns-forwarding-vda" {
  name    = "allow-server-dns-forwarding-vda"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "all"
  }
  source_ranges = ["35.199.192.0/19"]
  target_tags   = ["domaincontroller"]
}

# this allow IAP access https://github.com/GoogleCloudPlatform/iap-desktop
resource "google_compute_firewall" "allow-iap-tcp-vda" {
  name    = "allow-iap-tcp-vda"
  network = google_compute_network.vpc_vda.self_link
  allow {
    protocol = "tcp"
  }
  source_ranges = ["35.235.240.0/20"]
}