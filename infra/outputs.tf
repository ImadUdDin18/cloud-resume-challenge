output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting the site"
  value       = aws_s3_bucket.site.bucket
}

output "logs_bucket_name" {
  description = "Name of the S3 bucket storing CloudFront access logs"
  value       = aws_s3_bucket.logs.bucket
}

output "sns_alert_topic_arn" {
  description = "SNS topic ARN used for CloudWatch alarm notifications"
  value       = aws_sns_topic.alerts.arn
}
