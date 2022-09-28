terraform {
  required_providers {
    citrixadc = {
      source = "citrix/citrixadc"
    }
  }
}

provider "citrixadc" {
  endpoint = "https://34.141.178.250"
  username = "nsroot"
  password = "!Friskies2019!"
  alias = "primary"
  insecure_skip_verify = true
}

provider "citrixadc" {
  endpoint = "https://34.90.64.16"
  username = "nsroot"
  password = "!Friskies2019!"
  alias = "secondary"
  insecure_skip_verify = true
}