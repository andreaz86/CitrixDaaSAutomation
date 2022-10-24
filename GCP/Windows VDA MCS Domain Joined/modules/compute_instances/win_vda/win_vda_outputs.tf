output "winvda_external_ip" {
  value = {
    for k, vm_winvda in google_compute_instance.vm_winvda : k => vm_winvda.network_interface.0.access_config.0.nat_ip
  }
}