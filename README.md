# Cloud Resume Challenge
Personal Cloud and DevOps portfolio for **Imad Ud Din**.
## Current stage
Project complete. Static website deployed on AWS with S3, CloudFront, and HTTPS.
Infrastructure fully managed with Terraform. Deployments are automated with
GitHub Actions CI/CD. Monitoring and logging in place for visibility into
traffic and errors.
## Run locally
```powershell
node .\scripts\serve-local.mjs
```
Open `http://localhost:8001/` in a browser.
## Live site
https://dab49w3pv45ix.cloudfront.net
## Stack
- HTML, CSS, JavaScript
- Git and GitHub
- Amazon S3 and CloudFront
- Terraform
- GitHub Actions
- AWS CloudWatch, SNS
## Phase 8 - Monitoring & Logging (complete)
- CloudFront access logs delivered to a dedicated, private S3 bucket with a
  90-day lifecycle policy to auto-expire old logs
- CloudWatch alarm on CloudFront 5xx error rate (>5% over 5 minutes), covering
  both alarm and recovery (OK) states
- SNS email notifications wired to the alarm; CloudFront alarms and their SNS
  targets must both live in us-east-1, so a dedicated us-east-1 topic was
  provisioned specifically for this
- All of the above defined and provisioned through Terraform, alongside the
  rest of the infrastructure
## Phase 7 - CI/CD (complete)
- GitHub Actions workflow triggers on push to `main` when files under `src/` change
- Workflow syncs `src/` to S3 with `aws s3 sync --delete`
- Workflow invalidates CloudFront cache so changes go live immediately
- AWS access scoped to a dedicated IAM user with least-privilege permissions
  (S3 bucket actions + CloudFront invalidation only), credentials stored as
  encrypted GitHub Secrets
## Phase 6 - Terraform (complete)
- Existing S3 bucket, bucket policy, public access block, CloudFront distribution,
  and Origin Access Control all imported into Terraform state
- `terraform plan` confirms infrastructure matches configuration (no drift)
- Infrastructure as Code now manages all AWS resources going forward
## Phase 5 - CloudFront (complete)
- CloudFront distribution: dab49w3pv45ix.cloudfront.net
- Origin Access Control (OAC) securing S3 origin
- S3 bucket fully private, direct access blocked (403)
- HTTPS enforced via redirect-to-https
## Phase 4 - S3 Deployment (complete)
- Bucket: imad-cloud-resume-218908192593-ap-south-1 (ap-south-1)
- Fully private, Block Public Access enabled on all 4 settings
- Site files (index.html, css/, js/) uploaded via aws s3 sync
- No public read access - content only served via CloudFront (Phase 5)
