
variable "vpc_config" {
  type = object({
    cidr_block = string
    vpc_name   = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "the vcidr_block  config option must containe a valid cidr block"
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    azs        = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "the vcidr_block  config option must containe a valid cidr block"
  }
}