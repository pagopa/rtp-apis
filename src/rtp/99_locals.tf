locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  apim_name = "${local.product}-apim"
  apim_rg   = "${local.product}-api-rg"

  rtp_base_url  = "https://api-rtp.${var.dns_zone_prefix}"
  rtp_fe_origin = "${var.domain}.${var.dns_zone_prefix}"
}