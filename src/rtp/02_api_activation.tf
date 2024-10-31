## RTP Mock API ##
resource "azurerm_api_management_api" "rtp_activation_api" {
  name                = "${var.env_short}-rtp-activation-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  revision              = "1"
  description           = "RTP Activation API"
  display_name          = "RTP Activation API"
  path                  = "rtp/activation"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]
}

resource "azurerm_api_management_product_api" "rtp_activation_product_api" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  api_name            = azurerm_api_management_api.rtp_activation_api.name
  product_id          = azurerm_api_management_product.rtp.product_id
  depends_on          = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_activation_api]
}


## RTP Activation Operations ##
resource "azurerm_api_management_api_operation" "rtp_payee_activate" {
  operation_id        = "rtp_payee_activate"
  api_name            = azurerm_api_management_api.rtp_activation_api.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  display_name        = "RTP Payee Activation"
  method              = "POST"
  url_template        = "/api/v1/activate"
  description         = "Endpoint to activate a payee"
}
