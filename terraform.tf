provider "aws" {
  region  = var.region
  version = "~> 2.33.0"
}

terraform {
  backend "s3" {
    bucket = "tfstate.kibadex.net"
    key    = "infra/terraform.tfstate"
    region = "eu-west-3"
  }
}
