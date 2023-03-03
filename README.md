AWS :: IAM User
===============

Description
-----------
Terraform module provides the ability to define one or more IAM Users through a uniform configuration.

Example
-------
> [Example Module](./example/default) found in `./example/default`
* [Terraform Docs on S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)


Behaviors 
---------
API Key is not saved in state, you should create your own. 

      
Usage :: Defined Variables
--------------------------- 
```hcl-terraform

module "iam-users" {
    source = "git@github.com:dev-head/tf-module.aws.iam-user.git?ref=0.0.1"
    users = {
        test = {
            name = "test"
            access_keys = {
                default = { enabled = true }
            }
            aws_iam_policies = ["AmazonGlacierReadOnlyAccess", "ReadWriteDefiDataSyncSQS"]
        }
        foo = {
          name = "basic_foo"
        }
    }
}
```


Outputs 
-------
| key               | type      | Description 
|:-----------------:|:---------:| ------------------------------------------------------------------------------------:| 
| apply_metadata    | string    | Output metadata regarding the apply.
| key_attributes    | object    | Map of maps, indexed by they `var.keys` key, to ensure it's accessible.
| key_resources     | object    | Provide full access to resource objects.

#### Example
```
key_attributes = {
  test           = {
    arn       = "arn:aws:iam::5555555555:user/test"
    id        = "test"
    unique_id = "ABCDEFGHIGOTYALOOKINGLMNOP"
  }
}
```

Deployment 
----------
> Update the `CHANGELOG.md` please.

```
git tag -l
git tag -a 0.0.1
git show 0.0.1
git push origin 0.0.1
```
