# Silk Security Terraform Modules

## Usage

You can use it as:

```tf
provider "aws" {
  region  = "us-east-1"
}

module "silk_security_role" {
  source      = "github.com/silk-security/tf_modules//integration_role"
  external_id = "xxx"
}
```

## Inputs

| var               | description                                      | required           |
| ----------------- | ------------------------------------------------ | ------------------ |
| `external_id`     | The External Id provided by the Silk Wizard      | ✅                  |
| `allow_whitelist` | Allows the role to supress Security Hub warnings | Defaults to `true` |

## Outputs

The created role ARN can be retrieven through `role_arn`.
