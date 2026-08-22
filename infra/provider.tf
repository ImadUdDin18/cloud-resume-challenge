terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# CloudFront CloudWatch metrics only exist in us-east-1, regardless of
# where the distribution itself is "global"
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
