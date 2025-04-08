# general
prefix         = "cstar"
env_short      = "u"
env            = "uat"
domain         = "rtp"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "UAT"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/cstar-infrastructure"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "RTP"
}

dns_zone_prefix = "uat.cstar.pagopa.it"

enable_auth_send = true

enable_api_diagnostics = true