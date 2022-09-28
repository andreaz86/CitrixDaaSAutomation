output "domaincontroller_external_ip" {
  value = {
    for k, dc_vm in google_compute_instance.dc_vm : k => dc_vm.network_interface.0.access_config.0.nat_ip
  }
}