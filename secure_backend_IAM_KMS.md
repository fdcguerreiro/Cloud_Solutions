# Secure Remote State - IAM & KMS Enhancements

# Secure Remote State - IAM & KMS Enhancements

This document outlines the recent changes made to enhance the security of Terraform remote state using KMS and the necessary IAM configuration.

---

## KMS Integration for Remote State

The `state-backend` module was updated to include:

- **A dedicated KMS key** (`aws_kms_key.tf_state`) to encrypt the S3 bucket used for remote state.
- **S3 bucket configuration** to enforce server-side encryption using this KMS key.

### Outputs Added

In `outputs.tf` of the `state-backend` module, the following was added:

```hcl
output "kms_key_arn" {
  value = aws_kms_key.tf_state.arn
}
```

---

## Required IAM Permissions

Ensure that the IAM Role or User executing Terraform has the following permissions:

### S3 Bucket

- `s3:GetObject`  
- `s3:PutObject`  
- `s3:DeleteObject`  
- `s3:ListBucket`  

### DynamoDB (State Locking)

- `dynamodb:PutItem`  
- `dynamodb:GetItem`  
- `dynamodb:DeleteItem`  
- `dynamodb:UpdateItem`  

### KMS (for S3 encryption)

- `kms:Encrypt`  
- `kms:Decrypt`  
- `kms:DescribeKey`  
- `kms:GenerateDataKey`  

---

## Example IAM Policy

Replace `<region>`, `<account-id>`, and `<key-id>` accordingly:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowS3StateAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::terraform-state-cloud-app",
        "arn:aws:s3:::terraform-state-cloud-app/*"
      ]
    },
    {
      "Sid": "AllowDynamoDBLockAccess",
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem",
        "dynamodb:UpdateItem"
      ],
      "Resource": "arn:aws:dynamodb:<region>:<account-id>:table/terraform-locks"
    },
    {
      "Sid": "AllowKMSAccess",
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:GenerateDataKey"
      ],
      "Resource": "arn:aws:kms:<region>:<account-id>:key/<key-id>"
    }
  ]
}
