# Output public IP of VM for convenience

output "domaincontroller_external_ip" {
  value = module.domaincontroller.domaincontroller_external_ip
}

output "cloudconnector_external_ip" {
  value = module.cloudconnector.cloudconnector_external_ip
}

output "linvda_external_ip" {
  value = module.lin_vda.linvda_external_ip
}

