resource "azurerm_api_management_policy_fragment" "apim_rtp_validate_token" {
  name              = "rtp-validate-token-mcshared"
  api_management_id = data.azurerm_api_management.this.id

  description = "rtp-validate-token-mcshared"
  format      = "xml"
  value = templatefile("./api_fragment/validate-token-mcshared.xml", {
    mc_shared_base_url = "https://api-mcshared.${var.dns_zone_prefix}"
  })
}



resource "azurerm_api_management_policy_fragment" "apim_rtp_blob_storage_payees_validate_token" {
  name              = "rtp-validate-blob-storage-payees-token-mcshared"
  api_management_id = data.azurerm_api_management.this.id

  description = "rtp-validate-blob-storage-payees-token-mcshared"
  format      = "xml"
  value = templatefile("./api_fragment/validate-token-payees-mcshared_blob_storage.xml", {
    mc_shared_base_url = "https://api-mcshared.${var.dns_zone_prefix}",
    rtp_group_name     = var.rtp_payees_group_name,
  })
}

resource "azurerm_api_management_policy_fragment" "apim_rtp_blob_storage_service_providers_validate_token" {
  name              = "rtp-validate-blob-storage-service-providers-token-mcshared"
  api_management_id = data.azurerm_api_management.this.id

  description = "rtp-validate-blob-storage-service-providers-token-mcshared"
  format      = "xml"
  value = templatefile("./api_fragment/validate-token-service-providers-mcshared_blob_storage.xml", {
    mc_shared_base_url = "https://api-mcshared.${var.dns_zone_prefix}",
    rtp_group_name     = var.rtp_service_providers_group_name,
  })
}
