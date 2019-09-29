resource "aws_s3_bucket" "accesslog" {
  bucket = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], "all", var.name["Environment"], "all", "bs3", "log"])
  acl    = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_key.s3.arn
        sse_algorithm     = "aws:kms"
      }
    }
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
