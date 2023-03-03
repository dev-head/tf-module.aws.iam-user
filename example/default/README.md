AWS :: IAM User Example
=======================


Description
-----------
This is just a basic example, it represents a minimal configuration for IAM Users.


#### Change to required Terraform Version
```commandline
chtf 1.1.9
```

#### Make commands (includes local.ini support)
```commandline
make apply
make help
make plan
```

Example Outputs 
---------------
```
key_attributes = {
  test           = {
    arn       = "arn:aws:iam::5555555555:user/test"
    id        = "test"
    unique_id = "ABCDEFGHIGOTYALOOKINGLMNOP"
  }
}
```