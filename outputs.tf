
output "apply_metadata" {
  description = "Output metadata regarding the apply."
  value       = format("[%s]::[%s]::[%s]",
      data.aws_caller_identity.current.account_id,
      data.aws_caller_identity.current.arn,
      data.aws_caller_identity.current.user_id
  )
}

output  "key_attributes" {
    description = "Map of maps, indexed by they `var.keys` key, to ensure it's accessible."
    value = { 
        for key,v in var.users : key => {
            arn       = aws_iam_user.default[key].arn
            id        = aws_iam_user.default[key].name
            unique_id = aws_iam_user.default[key].unique_id
        }    
    }
}

output  "key_resources" {
  description = "Provide full access to resource objects."
  value = {
    for key,v in var.users : key => { user = aws_iam_user.default[key]}
  }
}
