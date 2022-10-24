output "linvda_external_ip" {
  value = {
    for k, vm_linvda in google_compute_instance.vm_linvda : k => vm_linvda.network_interface.0.access_config.0.nat_ip
  }
}