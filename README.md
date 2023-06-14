# Silk Security Terraform Modules

This repository holds all Terraform modules provided by Silk.

# Available modules

## Integration Role

The [Integration Role](./integration_role/) module creates an IAM Role that grants permission to the Silk Security App read/whitelist AWS Security Hub.

### Usage

Once you add an AWS Integration to your Silk account, you'll get an `external_id`.

This external ID should be given to this module.

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

### Inputs

| var               | description                                      | required           |
| ----------------- | ------------------------------------------------ | ------------------ |
| `external_id`     | The External Id provided by the Silk Wizard      | ✅                  |
| `allow_whitelist` | Allows the role to supress Security Hub warnings | Defaults to `true` |

### Outputs

The created role ARN can be retrieven through `role_arn`.
