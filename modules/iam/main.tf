resource "aws_iam_role" "terraform_exec_role" {
  name = "terraform-execution-role-${var.environment}"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]  # Adjust if used elsewhere
    }
  }
}

data "aws_iam_policy_document" "terraform_permissions" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      var.tfstate_bucket_arn,
      "${var.tfstate_bucket_arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [var.tfstate_dynamodb_arn]
  }

  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = [var.kms_key_arn]
  }
}

resource "aws_iam_policy" "terraform_policy" {
  name   = "terraform-policy-${var.environment}"
  policy = data.aws_iam_policy_document.terraform_permissions.json
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.terraform_exec_role.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}
