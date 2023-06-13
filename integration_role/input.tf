variable "external_id" {
  type        = string
  description = "The External Id provided by the Silk Wizard"
}

variable "allow_whitelist" {
  type        = bool
  default     = true
  description = "Whether to give the role Security Hub whitelist capabilities"
}
