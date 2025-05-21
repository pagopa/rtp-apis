resource "azurerm_api_management_api_policy" "rtp_registry_policies" {
  for_each = local.apis

  api_name            = each.value.api_ref.name
  api_management_name = data.azurerm_api_management.this.name
  resource_group_name = data.azurerm_api_management.this.resource_group_name

  xml_content = templatefile(
    each.value.xml_template,
    {
      mc_shared_base_url = local.mc_shared_base_url
      group_name         = var.api_group_names[each.key]
    }
  )

  depends_on = [
    azurerm_api_management_policy_fragment.apim_rtp_blob_storage_validate_token
  ]
}
