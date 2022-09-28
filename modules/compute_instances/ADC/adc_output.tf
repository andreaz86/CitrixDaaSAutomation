# output "adc_instance_id" {
#   value = {
#     for k, vm_adc in google_compute_instance.vm_adc : k => vm_adc.instance_id
#   }
# }


# output "adc_instances" {
#   value = google_compute_instance.vm_adc
# }

output "adc_instances" {
  value = tomap({ for instance in google_compute_instance.vm_adc : instance.network_interface.0.network_ip => instance.instance_id })
}

output "adc_names" {
  value = join("'", [for instance in google_compute_instance.vm_adc : instance.name])
}