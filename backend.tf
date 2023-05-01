terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    access_key  = "${var.access_key}"
    secret_key  = "${var.secret_key}"

    encrypt = true

    # aws_s3_bucket_versioning {
    #   enabled = true
    # }

    # Implement access controls to limit access to authorized users and services
    # A bucket policy that allows access only to specified IAM roles and users
#     bucket_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "TerraformBucketPolicy",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": [
#           "arn:aws:iam::123456789012:role/TerraformRole1",
#           "arn:aws:iam::123456789012:user/TerraformUser1"
#         ]
#       },
#       "Action": [
#         "s3:GetObject",
#         "s3:PutObject"
#       ],
#       "Resource": "arn:aws:s3:::terraform-state-bucket/*"
#     }
#   ]
# }
# POLICY

#     # Apply lifecycle policies to reduce storage costs and ensure compliance with data retention policies
#     lifecycle_rule {
#       id      = "state-file-retention"
#       status  = "Enabled"
#       prefix  = "terraform.tfstate"
#       enabled = true

#       # Archive previous versions after 30 days
#       transition {
#         days          = 30
#         storage_class = "GLACIER"
#       }

#       # Delete previous versions after 90 days
#       expiration {
#         days = 90
#       }
#     }
  }
}
