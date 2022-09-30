# Citrix DaaS Automation

Purpose of this project is to share a way to automate your Citrix DaaS deployment using terraform and ansible.
Some use cases that can be covered include:
- PoC
- Lab

## Features
Below a list of feature provided in this example:
- Deploy the required infrastracture on GCP using terraform:
    - Create 
- Ansible will take care of:
    - install domain on the Domain Controller VM
    - install software requirements from chocolatey public repo
    - join all Windows VM to domain
    - Install Cloud Connector and register it to Citrix Cloud
    - install VDA on a Windows VM
    - Create all Citrix Cloud stuff