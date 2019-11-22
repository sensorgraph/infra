# S3 - Access log
resource "aws_s3_bucket" "accesslog" {
  bucket = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "all", "bs3", "log"])
  acl    = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_alias.s3.target_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags   = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "all", "bs3", "log"])))
}

resource "aws_s3_bucket_public_access_block" "accesslog" {
  bucket                  = "${aws_s3_bucket.accesslog.id}"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 - Archive log
resource "aws_s3_bucket" "archivelog" {
  bucket = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "all", "bs3", "arc"])

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_alias.s3.target_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags   = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "all", "bs3", "arc"])))
}

resource "aws_s3_bucket_public_access_block" "archivelog" {
  bucket                  = aws_s3_bucket.archivelog.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# VPC Flow log

resource "aws_cloudwatch_log_group" "vpc" {
  name = "/flow-logs/vpc"
  tags = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])))
}

resource "aws_iam_role" "vpc_flow_logs" {
  name = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])
  assume_role_policy = file("files/iam/vpc-flow-logs-role.json")
  tags = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])))
}

data "template_file" "vpc_flow_logs_policy" {
  template = file("files/iam/vpc-flow-logs-policy.json.tpl")
  vars     = {
    cwl_arn = aws_cloudwatch_log_group.vpc.arn
  }
}

resource "aws_iam_role_policy" "vpc_flow_logs" {
  name = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])
  role = "${aws_iam_role.vpc_flow_logs.id}"
  policy = data.template_file.vpc_flow_logs_policy.rendered
}

resource "aws_flow_log" "vpc" {
  iam_role_arn    = "${aws_iam_role.vpc_flow_logs.arn}"
  log_destination = "${aws_cloudwatch_log_group.vpc.arn}"
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}