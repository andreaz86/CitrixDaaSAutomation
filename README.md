# Citrix DaaS Automation for GCP

Purpose of this project is to share a way to automate your Citrix DaaS deployment using terraform and ansible.
Some use cases that can be covered include:
- PoC
- Lab

Not to be exluded for production environment but remember this project is not officially supported and subject to modification in any time.
## Features
Below a list of feature provided in this project:
1. Deploy the required infrastracture on GCP using terraform:
    - Create different virtual machines for each role
    - Automatically create service account on GCP to be used in Citrix
    - Create two VPC with their subnetwork:
        - Server: for Infra VM
        - VDA: for the VDAs
    - Create Cloud DNS in order to resolv dns names of the domain:
    	- Forwading zone to the domain controller
        - Peering Zone between VDA and Server
2. Ansible will take care of:
    - install domain on the Domain Controller VM
    - install software requirements from chocolatey public repo
    - join all Windows VM to domain
    - Install Cloud Connector and register it to Citrix Cloud
    - install VDA on a Windows VM
    - Create all Citrix Cloud stuff using public API
## Design
This what on high level will look this project:

## Requirements
Before to preceed you need:
1. Generate client id and secret from your Citrix Tenant
2. Your account on GCP to be owner of the Project you want to use (terraform will create a ServiceAccount to be used for Citrix MCS)
3. A computer running Linux or Mac with Terraform and Ansible installed
    - If using Windows you can rely on WSL
4. test

## Assumptions
In this example, Terraform will deploy VM with public IP and use these IP to pass it on Ansible

