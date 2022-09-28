output "cloudconnector_external_ip" {
  value = {
    for k, vm_cc in google_compute_instance.vm_cc : k => vm_cc.network_interface.0.access_config.0.nat_ip
  }
}

 # output used to create variable to be consumed by ansible when configure the VDA
output "cc_names" {
  value = join(" ", [for instance in google_compute_instance.vm_cc : join("", [instance.name, ".", var.domain_fqdn])])
}

 # output used to create variable to be consumed by ansible when configure the VDA for wem agent (comma separated)
output "cc_names_wem" {
  value = join(",", [for instance in google_compute_instance.vm_cc : join("", [instance.name, ".", var.domain_fqdn])])
}