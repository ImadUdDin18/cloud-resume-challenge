# Cloud Resume Challenge

Personal Cloud and DevOps portfolio for **Imad Ud Din**.

## Current stage

The responsive static website is complete and tested locally. AWS infrastructure,
Terraform, and CI/CD will be added incrementally in later phases.

## Run locally

```powershell
node .\scripts\serve-local.mjs
```

Open `http://localhost:8001/` in a browser.

## Planned stack

- HTML, CSS, JavaScript
- Git and GitHub
- Amazon S3 and CloudFront
- Terraform
- GitHub Actions

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
