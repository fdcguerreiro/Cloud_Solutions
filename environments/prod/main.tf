module "prod" {
  source        = "../../"
  aws_region    = "eu-central-1"
  project_name  = "cloud-app-prod"
}
