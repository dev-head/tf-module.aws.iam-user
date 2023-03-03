data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  access_keys_list = flatten(try([for ukey,user in var.users : [
    for akey,access_key in user.access_keys: merge(access_key, {
      user_key  = ukey
      index     = akey
      user_name = user.name
      status    = access_key["enabled"]? "Active" : "Inactive"
    })
  ]], []))
  access_keys = { for item in local.access_keys_list : "${item.user_key}.${item.index}" => item }

  attach_aws_policies_list   = flatten([
    for key,user in var.users : [
      for policy in lookup(user, "aws_iam_policies", {}):
        { parent_key = key, name = policy }
      ]
    ])
  attach_aws_policies =  { for item in local.attach_aws_policies_list : "${item.parent_key}.${item.name}" => item }
}

data "aws_iam_policy" "aws-policy" {
  for_each  = local.attach_aws_policies
  name      = each.value["name"]
}