resource "google_compute_instance" "dc_vm" {
  for_each     = var.domaincontroller_vm
  name         = "${var.vmname_prefix}${each.value.name}"
  machine_type = each.value.vmtype
  zone         = each.value.zone
  tags         = ["ssh", "rdp", "domaincontroller"]
  enable_display = true
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = each.value.vmimage
      type  = each.value.disktype
    }
  }
  network_interface {
    subnetwork = var.server_subnetself_id
    network_ip = each.value.ip
    access_config {

    }
  }
  metadata = {
    windows-startup-script-cmd = "net user ${var.username} \"${var.password}\" /add /y & wmic UserAccount where Name=\"${var.username}\" set PasswordExpires=False & net localgroup administrators ${var.username} /add & powershell Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 & powershell New-ItemProperty -Path \"HKLM:\\SOFTWARE\\OpenSSH\" -Name DefaultShell -Value \"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe\" -PropertyType String -Force  & powershell Start-Service sshd & powershell Set-Service -Name sshd -StartupType 'Automatic' & powershell New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 & powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"Set-ExecutionPolicy -ExecutionPolicy bypass -Force\""
  }
}