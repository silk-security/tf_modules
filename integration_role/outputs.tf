output "role_arn" {
  description = "The created role ARN"
  value       = aws_iam_role.silk_security_integration_role.arn
}
