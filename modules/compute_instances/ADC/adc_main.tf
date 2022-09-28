resource "tls_private_key" "ssh_adc" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem_adc" {
  content         = tls_private_key.ssh_adc.private_key_pem
  filename        = ".ssh/adc"
  file_permission = "0600"
}

resource "google_compute_instance" "vm_adc" {
  for_each     = var.adc_vm
  name         = "${var.vmname_prefix}${each.value.name}"
  machine_type = each.value.vmtype
  zone         = each.value.zone
  tags         = ["ssh", "adc", "https"]

  boot_disk {
    device_name = "boot"
    auto_delete = true
    initialize_params {
      image = each.value.vmimage
    }
  }

  metadata = {
    ssh-keys = "nsroot:${tls_private_key.ssh_adc.public_key_openssh}"
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
    alias_ip_range {
      ip_cidr_range = "${each.value.snip}/32"
    }
  }

  allow_stopping_for_update = true

}
