variable "PROVIDER_TOKEN" {
  description = "API token for the provider."
  type        = string
}

variable "OS_NAME" {
  description = "Operating system to be used."
  type        = string
  default     = "ubuntu"
}

variable "OS_VERSION" {
  description = "Operating system version to be used."
  type        = string
  default     = "22.04"
}

variable "DEV_DOMAIN" {
  description = "Domain name to be associated with Dev server."
  type        = string
}
