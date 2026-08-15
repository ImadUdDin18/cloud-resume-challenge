# Phase 4 - S3 bucket setup & deployment commands
# Bucket: imad-cloud-resume-218908192593-ap-south-1
# Region: ap-south-1

# 1. Create bucket (private by default)
aws s3 mb s3://imad-cloud-resume-218908192593-ap-south-1 --region ap-south-1

# 2. Confirm Block Public Access is ON (should be true by default)
aws s3api get-public-access-block --bucket imad-cloud-resume-218908192593-ap-south-1

# 3. Upload site files
aws s3 sync src/ s3://imad-cloud-resume-218908192593-ap-south-1/ --exclude "*.map"

# 4. Verify upload
aws s3 ls s3://imad-cloud-resume-218908192593-ap-south-1 --recursive --human-readable --summarize