module "vpc" {
  source              = "./modules/VPC"
  vpc_config          = var.vpc_config
  gcp_region          = var.gcp_region
  cloudconnector_vm   = var.cloudconnector_vm
  domaincontroller_vm = var.domaincontroller_vm
}

module "cloudnat" {
  source          = "./modules/cloud_nat"
  cloudnat_prefix = var.vmname_prefix
  vda_vpcself_id  = module.vpc.vda_vpcself_id
  gcp_region      = var.gcp_region
}


module "iam" {
  source              = "./modules/iam"
  gcp_service_account = "${var.vmname_prefix}-terraform-sa"
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

# module "win_vda" {
#   source            = "./modules/compute_instances/win_vda"
#   winvda_vm         = var.winvda_vm
#   vda_subnetself_id = module.vpc.vda_subnetself_id
#   username          = var.username
#   password          = var.password
#   vmname_prefix     = var.vmname_prefix
# }

module "lin_vda" {
  source              = "./modules/compute_instances/lin_vda"
  linvda_vm           = var.linvda_vm
  vda_subnetself_id   = module.vpc.vda_subnetself_id
  username            = var.username
  password            = var.password
  vmname_prefix       = var.vmname_prefix
  ssh_private_key_pem = local_file.ssh_private_key_pem
  google_userinfo     = data.google_client_openid_userinfo.me
  tls_private_key     = tls_private_key.ssh
}


module "cloud_dns" {
  source              = "./modules/cloud_dns"
  domain_fqdn         = var.domain_fqdn
  vpc_server_selfid   = module.vpc.server_vpcself_id
  vpc_vda_selfid      = module.vpc.vda_vpcself_id
  domaincontroller_vm = var.domaincontroller_vm
}

