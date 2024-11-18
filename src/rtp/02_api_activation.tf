## RTP Activation API ##
resource "azurerm_api_management_api_version_set" "rtp_activation_api" {
  name                = "${var.env_short}-rtp-activation-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  display_name        = "RTP Activation API"
  versioning_scheme   = "Header"
  version_header_name = "Version"
}


resource "azurerm_api_management_api" "rtp_activation_api" {
  name                = "${var.env_short}-rtp-activation-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  version_set_id = azurerm_api_management_api_version_set.rtp_activation_api.id

  revision              = "1"
  version               = "v1"
  description           = "RTP Activation API"
  display_name          = "RTP Activation API"
  path                  = "rtp/activation"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]

  import {
    content_format = "openapi"
    content_value  = templatefile("./api/pagopa/activation.yaml", {})
  }
}

resource "azurerm_api_management_product_api" "rtp_activation_product_api" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  api_name            = azurerm_api_management_api.rtp_activation_api.name
  product_id          = azurerm_api_management_product.rtp.product_id
  depends_on          = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_activation_api]
}

## Define API Product Policy
resource "azurerm_api_management_api_policy" "rtp_activation_product_policy" {
  api_name            = azurerm_api_management_api.rtp_activation_api.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  xml_content = templatefile("./api/pagopa/activation_base_policy.xml", {})
  depends_on  = [azurerm_api_management_policy_fragment.apim_rtp_validate_token]
}

## Override API Operations Policies ##
resource "azurerm_api_management_api_operation_policy" "rtp_activate_policy" {
  api_name            = azurerm_api_management_api.rtp_activation_api.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  operation_id        = "activate"

  xml_content = templatefile("./api/pagopa/activation_policy.xml", {})
}
