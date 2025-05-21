locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  apim_name        = "${local.product}-apim"
  apim_rg          = "${local.product}-api-rg"
  apim_logger_name = "${local.product}-appinsights"
  apim_logger_id   = "${data.azurerm_api_management.this.id}/loggers/${local.apim_logger_name}"

  rtp_base_url  = "https://api-rtp.${var.dns_zone_prefix}"
  rtp_fe_origin = "${var.domain}.${var.dns_zone_prefix}"

  apis = {
    service_providers = {
      api_ref      = azurerm_api_management_api.rtp_service_providers_registry_api
      xml_template = "${path.module}/api/pagopa/service_providers_registry_base_policy.xml"
    }
    payees = {
      api_ref      = azurerm_api_management_api.rtp_payees_registry_api
      xml_template = "${path.module}/api/pagopa/payees_registry_base_policy.xml"
    }
  }

  mc_shared_base_url = "https://api-mcshared.${var.dns_zone_prefix}"


}
