data "aws_route53_zone" "main" {
  zone_id      = "ZC6V3SNTKD66O"
  private_zone = false
}

data "aws_kms_alias" "s3" {
  name = "alias/aws/s3"
}

data "aws_elb_service_account" "main" {}

data "template_file" "vpc_flow_logs_policy" {
  template = file("files/iam/vpc-flow-logs-policy.json.tpl")
  vars     = {
    cwl_arn = aws_cloudwatch_log_group.vpc.arn
  }
}

data "template_file" "lb_accesslog_policy" {
  template = file("files/iam/lb-accesslog-policy.json.tpl")
  vars     = {
    bucket_name    = aws_s3_bucket.lb_accesslog.id
    lb_account_arn = data.aws_elb_service_account.main.arn
  }
}