output "adm_instances" {
  value = tomap({ for instance in google_compute_instance.vm_adm : instance.network_interface.0.network_ip => instance.instance_id })
}