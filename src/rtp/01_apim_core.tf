# ------------------------------------------------------------------------------
# Product.
# ------------------------------------------------------------------------------
resource "azurerm_api_management_product" "rtp" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  product_id   = "rtp"
  display_name = "RTP Request To Pay"
  description  = "RTP Request To Pay"

  subscription_required = false
  published             = true
}

resource "azurerm_api_management_product_policy" "rtp_api_product" {
  product_id          = azurerm_api_management_product.rtp.product_id
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  xml_content = templatefile("./api_product/base_policy.xml", {
    rtp_fe_origin = local.rtp_fe_origin,
    dev_origin    = var.env_short != "d" ? "" : "\n<origin>http://localhost:1234</origin>"
  })
}

resource "azurerm_api_management_group" "rtp_group" {
  name                = var.domain
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  api_management_name = data.azurerm_api_management.this.name
  display_name        = upper(var.domain)
}

