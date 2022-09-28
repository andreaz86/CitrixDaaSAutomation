# resource "citrixadc_password_resetter" "primary_resetpwd" {
#     provider = citrixadc.primary
#     username = "nsroot"
#     password = "3951500478212166655"
#     new_password = "!Friskies2019!"
# }

resource "citrixadc_password_resetter" "secondary_resetpwd" {
    provider = citrixadc.secondary
    username = "nsroot"
    password = "3441405796789736447"
    new_password = "!Friskies2019!"
}

# resource "citrixadc_nshostname" "hostname_primary" {
#     provider = citrixadc.primary
#     hostname = "adc01"
# }

# resource "citrixadc_nshostname" "hostname_secondary" {
#     provider = citrixadc.secondary
#     hostname = "adc02"
# }

# resource "citrixadc_nsip" "primary_snip" {
#     provider = citrixadc.primary
#     ipaddress = "192.168.3.8"
#     netmask = "255.255.255.0"
#     type = "SNIP"
# }

# resource "citrixadc_nsip" "secondary_snip" {
#     provider = citrixadc.secondary
#     ipaddress = "192.168.3.10"
#     netmask = "255.255.255.0"
#     type = "SNIP"
# }

# resource "citrixadc_nslicense" "license_primary" {
#     provider = citrixadc.primary
#     license_file = file("${path.module}/CNS_V100000_SERVER_PLT_Retail.lic")
#     ssh_host_pubkey = file("${path.module}/adc.ssh")
# }

# resource "citrixadc_nslicense" "license_secondary" {
#     provider = citrixadc.primary
#     license_file = file("${path.module}/CNS_V100000_SERVER_PLT_Retail.lic")
#     ssh_host_pubkey = file("${path.module}/adc.ssh")
# }

# resource "citrixadc_hanode" "local_node" {
#     provider = citrixadc.primary
#     hanode_id     = 0       //the id of local_node is always 0
#     hellointerval = 400
#     deadinterval = 30
# }

# resource "citrixadc_hanode" "remote_node" {
#     provider = citrixadc.primary
#     hanode_id = 1
#     ipaddress = "192.168.3.9"
#     inc = "ENABLED"
# }

# resource "citrixadc_hanode" "test_local_node" {
#     provider = citrixadc.secondary
#     hanode_id     = 0       //the id of local_node is always 0
#     hellointerval = 400
#     deadinterval = 30
  
# }

# resource "citrixadc_hanode" "test_remote_node" {
#     provider = citrixadc.secondary
#     hanode_id = 1
#     ipaddress = "192.168.3.7"
#     inc = "ENABLED"
# }