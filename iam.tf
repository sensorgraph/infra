resource "aws_iam_role" "vpc_flow_logs" {
  name               = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])
  assume_role_policy = file("files/iam/vpc-flow-logs-role.json")
  tags               = merge(var.tags, map("Name", join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])))
}

resource "aws_iam_role_policy" "vpc_flow_logs" {
  name   = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "all", "flw"])
  role   = aws_iam_role.vpc_flow_logs.id
  policy = data.template_file.vpc_flow_logs_policy.rendered
}

resource "aws_iam_policy" "s3_logs_archive" {
  name   = join("-",[var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "pub", "pol", "log"])
  policy = data.template_file.s3_log_archive_policy.rendered
}
