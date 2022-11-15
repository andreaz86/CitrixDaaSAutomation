# This will create an inventory file to be used from ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("./templates/hosts.tftpl",
    {
      cloudconnector   = module.cloudconnector.cloudconnector_external_ip
      domaincontroller = module.domaincontroller.domaincontroller_external_ip
      #windowsvda                          = module.win_vda.winvda_external_ip
      linuxvda = module.lin_vda.linvda_external_ip
      terraform_user                      = var.username
      terraform_pwd                       = var.password
      admin_password                      = var.admin_password
      domain_fqdn                         = var.domain_fqdn
      ssh_username                        = local.ssh_username
      citrix_tenant                       = var.citrix_tenant
      citrix_client_id                    = var.citrix_client_id
      citrix_client_secret                = var.citrix_client_secret
      linuxvda_url                        = var.linuxvda_url
      resource_location_name              = var.resource_location_name
      hosting_connection_name             = var.hosting_connection_name
      hosting_connection_resoucepool_name = var.hosting_connection_resoucepool_name
      gcp_project_name                    = var.gcp_project_name
      gcp_region                          = var.gcp_region
      gcp_zone                            = var.gcp_zone
      subnetname                          = var.vpc_config.vda.subnet_name
      vpcname                             = var.vpc_config.vda.vpc_name
      gcp_sa_privatekey                   = replace(module.iam.serviceaccount_privatekey.private_key, "\n", "")
      gcp_sa_name                         = module.iam.serviceaccount_privatekey.client_email
      machinecatalog_name = var.machinecatalog_name
      deliverygroup_name  = var.deliverygroup_name
      vm2deply            = var.vm2deply
      cc_names            = module.cloudconnector.cc_names
      gcp_project_id      = var.gcp_project_id
      cc_names_wem        = module.cloudconnector.cc_names_wem
      vm_timezone         = var.vm_timezone
      dc_internal_ip      = var.domaincontroller_vm.dom01.ip
      dc_fqdn             = "${var.vmname_prefix}${var.domaincontroller_vm.dom01.name}.${var.domain_fqdn}"
      masterimagename     = "${var.vmname_prefix}${var.linvda_vm.linvda01.name}"
      users2create        = var.users2create
      adgroup2create      = var.adgroup2create
    }
  )
  filename = "./ansible/inventory.ini"
}
