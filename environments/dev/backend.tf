terraform {
  backend "s3" {
    bucket         = "terraform-state-cloud-app"
    key            = "dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
