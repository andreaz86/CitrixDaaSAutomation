 # Firewall rules applied to server VPC
 # ["${chomp(data.http.myip.response_body)}/32"] can be replaced by [0.0.0.0/0] to allow from anywhere

resource "google_compute_firewall" "default-allow-server" {
  name    = "allow-server-allow-any-local"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "all"
  }
  source_ranges = [var.vpc_config.server.subnet_cidr]
}

resource "google_compute_firewall" "allow-rdp-server" {
  name    = "allow-server-rdp"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  target_tags   = ["rdp"]
}

resource "google_compute_firewall" "allow-ssh-server" {
  name    = "allow-server-ssh"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "allow-dns-forwarding" {
  name    = "allow-server-dns-forwarding"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "all"
  }
  source_ranges = ["35.199.192.0/19"]
  target_tags   = ["domaincontroller"]
}

resource "google_compute_firewall" "allow-80-from-vda" {
  name    = "allow-80-from-vda"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = [var.vpc_config.vda.subnet_cidr]
  target_tags   = ["cloudconnector"]
}


resource "google_compute_firewall" "allow-server-fromvda" {
  name    = "allow-server-from-vda"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "all"
  }
  source_ranges = [var.vpc_config.vda.subnet_cidr]
}


resource "google_compute_firewall" "allow-iap-tcp-server" {
  name    = "allow-iap-tcp-server"
  network = google_compute_network.vpc_server.self_link
  allow {
    protocol = "tcp"
  }
  source_ranges = ["35.235.240.0/20"]
}