# Citrix DaaS Automation for GCP

Purpose of this project is to share a way to automate your Citrix DaaS deployment using terraform and ansible.
Some use cases that can be covered include:
- PoC
- Lab

Not to be exluded for production environment but remember this project is not officially supported and subject to modification at any time.
## Features
Below a list of feature provided in this project:
1. Deploy the required infrastracture on GCP using terraform:
    - Create different virtual machines for each role:
        - Domain Controller
        - Citrix Cloud Connectors
        - Master Image (Ubuntu Linux but Windows can be used with little code modification)
    - Automatically create service account on GCP to be used in Citrix
    - Create two VPC with their subnetwork:
        - Server: for Infra VM
        - VDA: for the VDAs
    - Create Cloud DNS in order to resolv dns names of the domain:
    	- Forwading zone to the domain controller
        - Peering Zone between VDA and Server
    - Create Cloud NAT for accessing internet from inside the provisioned MCS VM
2. Ansible will take care of:
    - install domain on the Domain Controller VM
        - Create a groups and a specified numbers of users
    - install software requirements from chocolatey public repo
    - join all Windows VM to domain
    - Install Cloud Connector and register it to Citrix Cloud (Creating a specific resource location)
    - install VDA on a Ubuntu VM
    - Create hosting connection inside Citrix DaaS
    - Create Machine Catalog based on Linux VM
    - Create Delivery Group based on the Machine Catalog
    - Publish a desktop and assign to a domain group
## Design
This what on high level will look this project:

## Requirements
Before to preceed you need:
1. Generate client id and secret from your Citrix Tenant (https://developer.cloud.com/citrix-cloud/citrix-cloud-api-overview/docs/get-started-with-citrix-cloud-apis)
    - keep note also of customer id (NOT the orgId)
2. Your account on GCP to be owner of the Project you want to use (terraform will create a ServiceAccount to be used for Citrix MCS).
3. Your computer running Linux, Mac or Windows with WSL:
    - Install terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli
    - Install Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
    - install jmespath from python-pip (pip3 install jmespath)


## Terraform
To start terraforming:
 - git clone this repo
 - rename the terraform.tfvars.example file in terraform.tfvars
    - change variables accondingly with your environment
- ```sh
terraform init
terraform plan
terraform apply
```
- terraform init
- terraform plan
- terraform apply

## Ansible
After terraform has completed, you can configure the environment usign ansible (wait 2-3 min before to be sure all services has been started):
- cd to ansible directory
- ansible-playbook -i ./inventory.ini site.yml

