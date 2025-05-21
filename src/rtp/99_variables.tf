variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type = string
}

variable "location_short" {
  type        = string
  description = "Location short like eg: neu, weu.."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) <= 12
    )
    error_message = "Max length is 12 chars."
  }
}

variable "dns_zone_prefix" {
  type        = string
  description = "The DNS zone prefix e.g. dev.cstar.pagopa.it"
}

variable "enable_auth_send" {
  type        = bool
  description = "Enable auth on RTP send API"
  default     = true
}

variable "enable_api_diagnostics" {
  description = "Flag to enable or disable API Management API diagnostics"
  type        = bool
  default     = false
}

variable "rtp_storage_account_name" {
  type        = string
  description = "The name of the storage account for RTP service registry"
}

variable "rtp_payees_group_name" {
  type        = string
  description = "JWT group claim payees"
}

variable "rtp_service_providers_group_name" {
  type        = string
  description = "JWT group claim service providers"
}
