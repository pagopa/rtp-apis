# general
prefix         = "cstar"
env_short      = "d"
env            = "dev"
domain         = "rtp"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "DEV"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/cstar-infrastructure"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "RTP"
}

dns_zone_prefix = "dev.cstar.pagopa.it"

enable_auth_send = true

enable_api_diagnostics = true

rtp_storage_account_name = "cstardweurtpblobstorage"