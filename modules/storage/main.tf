resource "aws_s3_bucket" "logs" {
  bucket = "${var.project_name}-logs"
  force_destroy = true
  tags = {
    Name = "Logs Bucket"
  }
}
