module "prod" {
  source        = "../../"
  aws_region    = "eu-central-1"
  project_name  = "cloud-app-prod"
}

module "iam" {
  source              = "../../modules/iam"
  environment         = var.environment
  tfstate_bucket_arn  = module.state_backend.bucket_arn
  tfstate_dynamodb_arn = module.state_backend.dynamodb_arn
  kms_key_arn         = module.state_backend.kms_key_arn
}
