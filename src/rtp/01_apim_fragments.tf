resource "azurerm_api_management_policy_fragment" "apim-validate-token-mil" {
  name              = "rtp-validate-token-mcshared"
  api_management_id = data.azurerm_api_management.this.id

  description = "rtp-validate-token-mcshared"
  format      = "xml"
  value = templatefile("./api_fragment/validate-token-mil.xml", {
    mc_shared_base_url = "https://api-mcshared.${var.dns_zone_prefix}"
  })
}