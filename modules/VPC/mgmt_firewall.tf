# resource "google_compute_firewall" "allow-ssh-mgmt" {
#   name    = "allow-ssh-mgmt"
#   network = google_compute_network.vpc_management.self_link
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
#   target_tags   = ["ssh"]
# }

# resource "google_compute_firewall" "allow-https-mgmt" {
#   name    = "allow-https-mgmt"
#   network = google_compute_network.vpc_management.self_link
#   allow {
#     protocol = "tcp"
#     ports    = ["443"]
#   }
#   source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
#   target_tags   = ["https"]
# }