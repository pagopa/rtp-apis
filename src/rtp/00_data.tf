data "azurerm_api_management" "this" {
  name                = local.apim_name
  resource_group_name = local.apim_rg
}

data "azurerm_container_app_environment" "cae" {
  name                = "${local.product}-mcshared-cae"
  resource_group_name = "${local.product}-mcshared-app-rg"
}