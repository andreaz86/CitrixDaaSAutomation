resource "google_compute_instance" "vm_linvda" {
  for_each     = var.linvda_vm
  name         = "${var.vmname_prefix}${each.value.name}"
  machine_type = each.value.vmtype
  zone         = each.value.zone
  tags         = ["ssh", "rdp", "vda"]
  enable_display = true
  allow_stopping_for_update = true
  
  boot_disk {
    initialize_params {
      image = each.value.vmimage
      type  = each.value.disktype
      size  = each.value.disksize
    }
  }
  network_interface {
    subnetwork = var.vda_subnetself_id
    access_config {

    }
  }
  metadata = {
    ssh-keys = "${split("@", var.google_userinfo.email)[0]}:${var.tls_private_key.public_key_openssh}"
  }
}


