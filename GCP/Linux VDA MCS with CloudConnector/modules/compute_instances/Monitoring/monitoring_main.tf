data "google_client_openid_userinfo" "me" {}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = ".ssh/google_compute_engine"
  file_permission = "0600"
}

resource "google_compute_instance" "mon_vm" {
  for_each     = var.monitoring_vm
  name         = "${var.vmname_prefix}${each.value.name}"
  machine_type = each.value.vmtype
  zone         = each.value.zone
  tags         = ["ssh", "monitoring"]
  scheduling {
    provisioning_model          = "SPOT"
    preemptible                 = "true"
    automatic_restart           = "false"
    instance_termination_action = "STOP"
  }
  boot_disk {
    initialize_params {
      image = each.value.vmimage
      type  = each.value.disktype
      size  = each.value.disksize
    }
  }
  network_interface {
    subnetwork = var.server_subnetself_id
    network_ip = each.value.ip
    access_config {

    }
  }
  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }
}