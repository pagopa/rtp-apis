resource "azurerm_api_management_policy_fragment" "apim_rtp_validate_token" {
  name              = "rtp-validate-token-mcshared"
  api_management_id = data.azurerm_api_management.this.id

  description = "rtp-validate-token-mcshared"
  format      = "xml"
  value = templatefile("./api_fragment/validate-token-mcshared.xml", {
    mc_shared_base_url = "https://api-mcshared.${var.dns_zone_prefix}"
  })
}

resource "azurerm_api_management_policy_fragment" "apim_rtp_blob_storage_validate_token" {
  name              = "rtp-validate-blob-storage-token-mcshared"
  api_management_id = data.azurerm_api_management.this.id

  description = "rtp-validate-blob-storage-token-mcshared"
  format      = "xml"
  value = templatefile(
    "./api_fragment/validate-token-mcshared_blob_storage.xml",
    {
      mc_shared_base_url = local.mc_shared_base_url
      group_name         = var.api_group_names["service_providers"]
    }
  )
}


