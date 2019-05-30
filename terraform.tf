provider "aws" {
  region  = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "tfstate.kibadex.net"
    key    = "infra/terraform.tfstate"
    region = "eu-west-3"
  }
}