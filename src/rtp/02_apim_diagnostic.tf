locals {
  rtp_apim_api_diagnostics = var.enable_api_diagnostics ? [
    azurerm_api_management_api_version_set.rtp_activation_api.name,
    azurerm_api_management_api_version_set.rtp_service_provider_api.name,
    azurerm_api_management_api_version_set.rtp_callback_api.name,
  ] : []
}

resource "azurerm_api_management_api_diagnostic" "rtp_apim_api_diagnostics" {
  for_each = toset(local.rtp_apim_api_diagnostics)

  identifier               = "applicationinsights"
  resource_group_name      = data.azurerm_api_management.this.resource_group_name
  api_management_name      = data.azurerm_api_management.this.name
  api_name                 = each.key
  api_management_logger_id = local.apim_logger_id

  sampling_percentage       = 100.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "information"
  http_correlation_protocol = "W3C"

  frontend_request {
    headers_to_log = [
      "RequestId"
    ]
  }
}