# general
prefix         = "cstar"
env_short      = "p"
env            = "prod"
domain         = "rtp"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "PROD"
  Owner       = "CSTAR"
  Source      = "https://github.com/pagopa/cstar-infrastructure"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  Application = "RTP"
}

dns_zone_prefix = "cstar.pagopa.it"

enable_auth_send = true

enable_api_diagnostics = true

rtp_storage_account_name = "cstarpweurtpblobstorage"

rtp_payees_group_name = "read_rtp_payees"
rtp_service_providers_group_name = "read_service_registry"