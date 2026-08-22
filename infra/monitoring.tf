# -----------------------------
# S3 bucket to store CloudFront access logs
# -----------------------------
resource "aws_s3_bucket" "logs" {
  bucket = "${var.bucket_name}-logs"
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  depends_on = [aws_s3_bucket_ownership_controls.logs]
  bucket     = aws_s3_bucket.logs.id
  acl        = "log-delivery-write"
}

# Auto-delete old logs after 90 days to keep storage cost near zero
resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = 90
    }
  }
}

# -----------------------------
# SNS topic for alarm notifications (ap-south-1, for general use)
# -----------------------------
resource "aws_sns_topic" "alerts" {
  name = "cloud-resume-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# -----------------------------
# SNS topic in us-east-1: CloudFront CloudWatch alarms can only send
# notifications to SNS topics that also live in us-east-1
# -----------------------------
resource "aws_sns_topic" "alerts_us_east_1" {
  provider = aws.us_east_1
  name     = "cloud-resume-alerts-us-east-1"
}

resource "aws_sns_topic_subscription" "email_alert_us_east_1" {
  provider  = aws.us_east_1
  topic_arn = aws_sns_topic.alerts_us_east_1.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# -----------------------------
# CloudWatch Alarm: alert on high CloudFront 5xx error rate
# CloudFront metrics are only available in us-east-1
# -----------------------------
resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx" {
  provider = aws.us_east_1

  alarm_name          = "cloud-resume-cloudfront-5xx-errors"
  alarm_description   = "Triggers when CloudFront 5xx error rate exceeds 5% over 5 minutes"
  namespace           = "AWS/CloudFront"
  metric_name         = "5xxErrorRate"
  statistic           = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 5
  period              = 300
  evaluation_periods  = 1
  treat_missing_data  = "notBreaching"

  dimensions = {
    DistributionId = aws_cloudfront_distribution.site.id
    Region         = "Global"
  }

  alarm_actions = [aws_sns_topic.alerts_us_east_1.arn]
  ok_actions    = [aws_sns_topic.alerts_us_east_1.arn]
}
