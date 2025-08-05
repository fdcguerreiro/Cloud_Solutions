provider "aws" {
  region = "eu-central-1"
}

module "state_backend" {
  source              = "./modules/state-backend"
  bucket_name         = "terraform-state-cloud-app"
  dynamodb_table_name = "terraform-locks"
  environment         = "global"
}
