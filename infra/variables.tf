variable "aws_region" {
  description = "AWS region where the S3 bucket lives"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Name of the existing S3 bucket hosting the static site"
  type        = string
  default     = "imad-cloud-resume-218908192593-ap-south-1"
}

variable "aws_account_id" {
  description = "AWS account ID that owns these resources"
  type        = string
  default     = "218908192593"
}
