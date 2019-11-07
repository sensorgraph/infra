data "aws_route53_zone" "main" {
  zone_id      = "ZC6V3SNTKD66O"
  private_zone = false
}

data "aws_kms_alias" "s3" {
  name = "alias/aws/s3"
}