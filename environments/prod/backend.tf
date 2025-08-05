terraform {
  backend "s3" {
    bucket         = "terraform-state-cloud-app"
    key            = "prod/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
