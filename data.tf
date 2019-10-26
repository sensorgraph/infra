data "aws_route53_zone" "main" {
  zone_id      = "ZC6V3SNTKD66O"
  private_zone = false
}
data "aws_kms_key" "s3" {
  key_id = "arn:aws:kms:eu-west-3:649987087669:key/7f4a8b32-85a5-4962-b472-4e555dd1d13f"
  #key_id = "aws/s3"}
}
