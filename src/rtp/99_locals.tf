locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  apim_name = "${local.product}-apim"
  apim_rg   = "${local.product}-api-rg"
}