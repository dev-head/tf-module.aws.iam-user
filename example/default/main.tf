#------------------------------------------------------------------------------#
# @title: Terraform Example
# @description: Used to test and provide a working example for this module.
#------------------------------------------------------------------------------#

terraform {
  required_version  = "~> 1.1.9"
  experiments       = [module_variable_optional_attrs]  
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "example" {
    source = "../../"
    users = {
        test = {
            name = "test"
            access_keys = {
                default = { enabled = true }
            }
            aws_iam_policies = ["AmazonGlacierReadOnlyAccess", "ReadWriteDefiDataSyncSQS"]
        }
    }
}

output "metadata" {
    description = "Output metadata regarding the apply."
    value       = module.example.apply_metadata
}

output "key_attributes" {
    description = "Output key attributes from this module."
    value       = module.example.key_attributes
}
