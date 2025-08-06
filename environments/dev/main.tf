module "dev" {
  source = "../../"
  aws_region = "eu-central-1"
}

module "iam" {
  source              = "../../modules/iam"
  environment         = var.environment
  tfstate_bucket_arn  = module.state_backend.bucket_arn
  tfstate_dynamodb_arn = module.state_backend.dynamodb_arn
  kms_key_arn         = module.state_backend.kms_key_arn
}
