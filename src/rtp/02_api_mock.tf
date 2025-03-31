###### Mock EPC API ######
resource "azurerm_api_management_api" "rtp_mock_api_epc" {
  name                = "${var.env_short}-rtp-mock-api-epc"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  revision              = "1"
  description           = "RTP MOCK API EPC"
  display_name          = "RTP MOCK API EPC"
  path                  = "rtp/mock"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]

  import {
    content_format = "openapi"
    content_value  = templatefile("./api/epc/EPC133-22_v3.1_SRTP_spec.openapi.yaml", {})
  }
}

resource "azurerm_api_management_product_api" "rtp_mock_product_api_epc" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  api_name            = azurerm_api_management_api.rtp_mock_api_epc.name
  product_id          = azurerm_api_management_product.rtp.product_id
  depends_on          = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_mock_api_epc]
}

resource "azurerm_api_management_api_operation_policy" "rtp_mock_send_srtp" {
  api_name            = azurerm_api_management_api.rtp_mock_api_epc.name
  api_management_name = azurerm_api_management_api.rtp_mock_api_epc.api_management_name
  resource_group_name = azurerm_api_management_api.rtp_mock_api_epc.resource_group_name
  operation_id        = "postRequestToPayRequests"

  xml_content = file("./api/test/mock_policy_epc.xml")
}

resource "azurerm_api_management_api_operation_policy" "rtp_mock_cancellation_srtp" {
  api_name            = azurerm_api_management_api.rtp_mock_api_epc.name
  api_management_name = azurerm_api_management_api.rtp_mock_api_epc.api_management_name
  resource_group_name = azurerm_api_management_api.rtp_mock_api_epc.resource_group_name
  operation_id        = "postRequestToPayCancellationRequest"

  xml_content = file("./api/test/mock_policy_epc.xml")
}
