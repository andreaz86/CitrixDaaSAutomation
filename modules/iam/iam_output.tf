output "serviceaccount_privatekey" {
  value = jsondecode(base64decode(google_service_account_key.mykey.private_key))
}

