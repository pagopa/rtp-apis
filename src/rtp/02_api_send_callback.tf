## RTP Send Callback API ##
resource "azurerm_api_management_api_version_set" "rtp_send_callback_api" {
  name                = "${var.env_short}-rtp-send-callback-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  display_name        = "RTP Send Callback API"
  versioning_scheme   = "Header"
  version_header_name = "Version"
}



resource "azurerm_api_management_api" "rtp_send_callback_api" {
  name                = "${var.env_short}-rtp-send-callback-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  version_set_id = azurerm_api_management_api_version_set.rtp_send_callback_api.id

  revision              = "1"
  version               = "v1"
  description           = "RTP SEND CALLBACK API"
  display_name          = "RTP SEND CALLBACK API"
  path                  = "rtp/send-callback"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]

  service_url = "https://${local.product}-rtp-activator-ca.${data.azurerm_container_app_environment.cae.default_domain}"

  import {
    content_format = "openapi"
    content_value  = templatefile("./api/pagopa/send_callback.openapi.yaml", {})
  }
}

resource "azurerm_api_management_product_api" "rtp_send_callback_product_api" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  api_name   = azurerm_api_management_api.rtp_send_callback_api.name
  product_id = azurerm_api_management_product.rtp.product_id
  depends_on = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_send_callback_api]
}