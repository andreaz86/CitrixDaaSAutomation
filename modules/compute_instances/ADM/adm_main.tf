resource "google_compute_instance" "vm_adm" {
  for_each     = var.adm_vm
  name         = "${var.vmname_prefix}${each.value.name}"
  machine_type = each.value.vmtype
  zone         = each.value.zone
  tags         = ["ssh", "adm", "https"]

  boot_disk {
    device_name = "boot"
    auto_delete = true
    initialize_params {
      image = each.value.vmimage
    }
  }



  scheduling {
    provisioning_model          = "SPOT"
    preemptible                 = "true"
    automatic_restart           = "false"
    instance_termination_action = "STOP"
  }

  # Management NIC
  network_interface {
    subnetwork = var.server_subnetself_id
    network_ip = each.value.server_ip
    access_config {
    }

  }

  allow_stopping_for_update = true

}
