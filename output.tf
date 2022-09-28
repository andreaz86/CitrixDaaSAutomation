output "domaincontroller_external_ip" {
  value = module.domaincontroller.domaincontroller_external_ip
}
output "cloudconnector_external_ip" {
  value = module.cloudconnector.cloudconnector_external_ip
}

output "vda_external_ip" {
  value = module.win_vda.vda_external_ip
}

output "monitoring_external_ip" {
  value = module.monitoring.monitoring_external_ip
}

output "test" {
  value = module.cloudconnector.cc_names

}
