resource "aws_s3_bucket" "terra_bucket" {
  bucket = "gaia-cloud-config"

  versioning {
    enabled = true
  }
}