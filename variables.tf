variable "users" {
  description = "Configuration object of one or more IAM users to manage."
  type = map(object({
    name                  = string 
    path                  = optional(string)
    permissions_boundary  = optional(string)
    force_destroy         = optional(bool)
    tags                  = optional(map(any))
    groups                = optional(list(string))
    aws_iam_policies      = optional(list(string))
    access_keys = optional(map(object({
      enabled = bool
      pgp_key = optional(string)
    })))    
  }))
}