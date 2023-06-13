terraform {
  required_version = ">=0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

locals {
  silk_security_arn = "arn:aws:iam::340199105480:root"
}

resource "aws_iam_role" "silk_security_integration_role" {
  name = "SilkSecurityIntegrationRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : local.silk_security_arn
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "sts:ExternalId" : var.external_id
          }
        }
      }
    ]
  })

  tags = {
    managed_by = "silk_security"
  }

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/AWSSecurityHubReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSConfigUserAccess",
    "arn:aws:iam::aws:policy/ResourceGroupsandTagEditorReadOnlyAccess"
  ]

  dynamic "inline_policy" {
    for_each = var.allow_whitelist ? toset([1]) : toset([])

    content {
      name = "SuppressPolicy"
      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : "securityhub:BatchUpdateFindings",
            "Resource" : "*"
          }
        ]
      })
    }
  }
}
