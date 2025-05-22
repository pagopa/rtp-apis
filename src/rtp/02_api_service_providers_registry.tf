## RTP Service Providers Registry API ##
resource "azurerm_api_management_api_version_set" "rtp_service_providers_registry_api" {
  name                = "${var.env_short}-rtp-service_providers-registry-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  display_name        = "RTP Service Providers Registry API"
  versioning_scheme   = "Header"
  version_header_name = "Version"
}

resource "azurerm_api_management_api" "rtp_service_providers_registry_api" {
  name                = "${var.env_short}-rtp-service_providers-registry-api"
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  version_set_id = azurerm_api_management_api_version_set.rtp_service_providers_registry_api.id

  revision              = "1"
  version               = "v1"
  description           = "RTP Service Providers Registry API"
  display_name          = "RTP Service Providers Registry API"
  path                  = "rtp/service_providers"
  protocols             = ["https"]
  subscription_required = false

  depends_on = [azurerm_api_management_product.rtp]

  service_url = "https://${local.product}-rtp-activator-ca.${data.azurerm_container_app_environment.cae.default_domain}"

  import {
    content_format = "openapi"
    content_value  = templatefile("./api/pagopa/service_providers_registry.yaml", {})
  }
}

resource "azurerm_api_management_product_api" "rtp_service_providers_registry_product_api" {
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  api_name   = azurerm_api_management_api.rtp_service_providers_registry_api.name
  product_id = azurerm_api_management_product.rtp.product_id
  depends_on = [azurerm_api_management_product.rtp, azurerm_api_management_api.rtp_service_providers_registry_api]
}

resource "azurerm_api_management_api_policy" "rtp_service_providers_registry_policy" {
  api_name            = azurerm_api_management_api.rtp_service_providers_registry_api.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  xml_content = templatefile("./api/pagopa/service_providers_registry_base_policy.xml", {})
  depends_on  = [azurerm_api_management_policy_fragment.apim_rtp_blob_storage_service_providers_validate_token]
}

resource "azurerm_api_management_api_operation_policy" "rtp_service_providers_registry_get_policy" {
  api_name            = azurerm_api_management_api.rtp_service_providers_registry_api.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name
  operation_id        = "getServiceProviders"

  xml_content = templatefile(
    "${path.module}/api/pagopa/service_providers_registry_get_policy.xml",
    { storage_account_name = var.rtp_storage_account_name }
  )
}
