terraform {
  backend "s3" {
    bucket = "terraformbucket0706"
    key = "terraform/backend"
    region = "eu-north-1"
  }
}