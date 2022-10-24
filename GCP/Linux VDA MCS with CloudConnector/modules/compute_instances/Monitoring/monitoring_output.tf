output "monitoring_external_ip" {
  value = {
    for k, mon_vm in google_compute_instance.mon_vm : k => mon_vm.network_interface.0.access_config.0.nat_ip
  }
}

output "ssh_username" {
  value = split("@", data.google_client_openid_userinfo.me.email)[0]
}