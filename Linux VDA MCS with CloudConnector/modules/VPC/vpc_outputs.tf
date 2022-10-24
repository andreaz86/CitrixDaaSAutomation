

output "server_vpcself_id" {
  value = google_compute_network.vpc_server.self_link
}

output "vda_vpcself_id" {
  value = google_compute_network.vpc_vda.self_link
}

 # Output subnetwork selfid

output "server_subnetself_id" {
  value = google_compute_subnetwork.server_subnet.self_link
}

output "vda_subnetself_id" {
  value = google_compute_subnetwork.vda_subnet.self_link
}



# output "cc_private_ip" {
#   value = {
#     for k, cloudconnector_internal_ip in google_compute_address.cloudconnector_internal_ip : k => cloudconnector_internal_ip.name
#   }
# }

