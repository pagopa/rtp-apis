## RTP Service Provider API ##
resource "azurerm_api_management_api_version_set" "rtp_service_provider_api" {
  name                = "${var.env_short}-rtp-service-provider-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  display_name        = "RTP Service Provider API"
  versioning_scheme   = "Header"
  version_header_name = "Version"
}

resource "azurerm_api_management_api" "rtp_service_provider_api" {
  name                = "${var.env_short}-rtp-service-provider-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  version_set_id = azurerm_api_management_api_version_set.rtp_service_provider_api.id

  revision              = "1"
  version               = "v1"
  description           = "RTP Service Provider API"
  display_name          = "RTP Service Provider API"
  path                  = "rtp"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]

  service_url = "https://${local.product}-rtp-activator-ca.${data.azurerm_container_app_environment.cae.default_domain}"

  import {
    content_format = "openapi"
    content_value  = templatefile("./api/pagopa/send.openapi.yaml", {})
  }
}

resource "azurerm_api_management_product_api" "rtp_service_provider_product_api" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  api_name   = azurerm_api_management_api.rtp_service_provider_api.name
  product_id = azurerm_api_management_product.rtp.product_id
  depends_on = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_service_provider_api]
}

## Override API Operations Policies ##
resource "azurerm_api_management_api_operation_policy" "rtp_service_provider_create_rtp_policy" {
  api_name            = azurerm_api_management_api.rtp_service_provider_api.name
  api_management_name = azurerm_api_management_api.rtp_service_provider_api.api_management_name
  resource_group_name = azurerm_api_management_api.rtp_service_provider_api.resource_group_name
  operation_id        = "createRtp"

  xml_content = templatefile("./api/pagopa/send_policy.xml", {
    enableAuth = var.enable_auth_send
  })

  depends_on = [azurerm_api_management_policy_fragment.apim_rtp_validate_token]
}
