module "vpc" {
  source              = "./modules/VPC"
  vpc_config          = var.vpc_config
  gcp_region          = var.gcp_region
  cloudconnector_vm   = var.cloudconnector_vm
  storefront_vm       = var.storefront_vm
  monitoring_vm       = var.monitoring_vm
  domaincontroller_vm = var.domaincontroller_vm
  adc_vm              = var.adc_vm
}

module "iam" {
  source              = "./modules/iam"
  gcp_service_account = var.gcp_service_account
  gcp_project_id      = var.gcp_project_id
}

module "cloudconnector" {
  source               = "./modules/compute_instances/CC"
  vpc_selfid           = module.vpc.server_vpcself_id
  cloudconnector_vm    = var.cloudconnector_vm
  server_subnetself_id = module.vpc.server_subnetself_id
  username             = var.username
  password             = var.password
  vmname_prefix        = var.vmname_prefix
  domain_fqdn          = var.domain_fqdn
}

module "domaincontroller" {
  source               = "./modules/compute_instances/DC"
  vpc_selfid           = module.vpc.server_vpcself_id
  domaincontroller_vm  = var.domaincontroller_vm
  server_subnetself_id = module.vpc.server_subnetself_id
  username             = var.username
  password             = var.password
  vmname_prefix        = var.vmname_prefix
}

/* module "storefront" {
  source               = "./modules/compute_instances/StoreFront"
  vpc_selfid           = module.vpc.server_vpcself_id
  storefront_vm        = var.storefront_vm
  server_subnetself_id = module.vpc.server_subnetself_id
  username             = var.username
  password             = var.password
  vmname_prefix        = var.vmname_prefix
} */

module "monitoring" {
  source               = "./modules/compute_instances/Monitoring"
  vpc_selfid           = module.vpc.server_vpcself_id
  monitoring_vm        = var.monitoring_vm
  server_subnetself_id = module.vpc.server_subnetself_id
  username             = var.username
  password             = var.password
  vmname_prefix        = var.vmname_prefix
}

module "win_vda" {
  source            = "./modules/compute_instances/VDA"
  vpc_selfid        = module.vpc.server_vpcself_id
  winvda_vm         = var.winvda_vm
  vda_subnetself_id = module.vpc.vda_subnetself_id
  username          = var.username
  password          = var.password
  vmname_prefix     = var.vmname_prefix
}

module "adc" {
  source               = "./modules/compute_instances/ADC"
  adc_vm               = var.adc_vm
  vmname_prefix        = var.vmname_prefix
  server_subnetself_id = module.vpc.server_subnetself_id
}

module "adm" {
  source               = "./modules/compute_instances/ADM"
  adm_vm               = var.adm_vm
  vmname_prefix        = var.vmname_prefix
  server_subnetself_id = module.vpc.server_subnetself_id
}

module "cloud_dns" {
  source              = "./modules/cloud_dns"
  domain_fqdn         = var.domain_fqdn
  vpc_server_selfid   = module.vpc.server_vpcself_id
  vpc_vda_selfid      = module.vpc.vda_vpcself_id
  domaincontroller_vm = var.domaincontroller_vm
  #dc_privateip        = module.domaincontroller.out_dc_privateip
}


# resource "local_file" "cc_install" {
#   content = templatefile("./templates/cc_install.tpl",
#     {
#       customername = var.citrix_tenant
#       citrix_id = var.citrix_id
#       citrix_secret = var.citrix_secret
#       #citrix_resloc_id = var.citrix_resloc_id
#     }
#   )
#   filename = "./ansible/roles/cloudconnector/files/cwcconnector_install_params.json"
# }