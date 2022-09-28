output "monitoring_external_ip" {
  value = {
    for k, stf_vm in google_compute_instance.stf_vm : k => stf_vm.network_interface.0.access_config.0.nat_ip
  }
}