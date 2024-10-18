## RTP Mock API ##
resource "azurerm_api_management_api" "rtp_mock_api" {
  name                = "${var.env_short}-rtp-mock-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  revision              = "1"
  description           = "RTP MOCK API"
  display_name          = "RTP MOCK API"
  path                  = "rtp/mock"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]
}

resource "azurerm_api_management_product_api" "rtp_mock_product_api" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  api_name            = azurerm_api_management_api.rtp_mock_api.name
  product_id          = azurerm_api_management_product.rtp.product_id
  depends_on          = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_mock_api]
}


## RTP Mock Operations ##
resource "azurerm_api_management_api_operation" "rtp_mock_create_ticket" {
  operation_id        = "rtp_mock_create_ticket"
  api_name            = azurerm_api_management_api.rtp_mock_api.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  display_name        = "RTP Mock create ticket"
  method              = "POST"
  url_template        = "/api/v1/create"
  description         = "Endpoint for create a rtp ticket api"
}

resource "azurerm_api_management_api_operation_policy" "rtp_mock_create_ticket_policy" {
  api_name            = azurerm_api_management_api_operation.rtp_mock_create_ticket.api_name
  api_management_name = azurerm_api_management_api_operation.rtp_mock_create_ticket.api_management_name
  resource_group_name = azurerm_api_management_api_operation.rtp_mock_create_ticket.resource_group_name
  operation_id        = azurerm_api_management_api_operation.rtp_mock_create_ticket.operation_id

  xml_content = templatefile("./api/test/mock_policy.xml", {
    env = var.env
  })

  depends_on = [azurerm_api_management_api_operation.rtp_mock_create_ticket]

}