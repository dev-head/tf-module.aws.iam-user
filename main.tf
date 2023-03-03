resource "aws_iam_user" "default" {
  for_each              = var.users
  name                  = lookup(each.value, "name")
  path                  = coalesce(each.value["path"], false)? lookup(each.value, "path") : null
  permissions_boundary  = coalesce(each.value["permissions_boundary"], false)? lookup(each.value, "permissions_boundary") : null
  force_destroy         = coalesce(each.value["force_destroy"], false)? lookup(each.value, "force_destroy") : null
  tags                  = coalesce(each.value["tags"], {})
}

resource "aws_iam_user_group_membership" "default" {
  for_each  = var.users
  user      = aws_iam_user.default[each.key].name
  groups    = coalesce(each.value["groups"], [])
}

resource "aws_iam_access_key" "default" {
  for_each  = local.access_keys
  user      = aws_iam_user.default[each.value["user_key"]].name
  status    = each.value["status"] 
}

resource "aws_iam_user_policy_attachment" "aws-policy" {
  for_each    = local.attach_aws_policies
  user        = aws_iam_user.default[each.value["parent_key"]].name    
  policy_arn  = data.aws_iam_policy.aws-policy[each.key].arn
}