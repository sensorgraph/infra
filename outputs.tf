output "region" {
  value       = var.region
  description = "The main region"
}

output "availability_zones" {
  value       = var.availability_zones
  description = "The AZs to be used on the infrastructure"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of main VPC"
}

output "vpc_cidr" {
  value       = var.vpc_cidr
  description = "The VPC CIDR"
}

output "public_subnet_id" {
  value       = aws_subnet.public.*.id
  description = "The IDs of public subnets"
}

output "public_subnet_cidr" {
  value        = aws_subnet.public.*.cidr_block
  description = "The both IPs range useds in the public subnet" 
}

output "private_subnet_id" {
  value       = aws_subnet.private.*.id
  description = "The IDs of private subnets"
}

output "private_private_cidr" {
  value        = aws_subnet.private.*.cidr_block
  description = "The both IPs range used in the private subnet"
}

output "bucket_name_s3_accesslog_bucket" {
  value       = aws_s3_bucket.s3_accesslog.bucket
  description = "Bucket to use for logging the acceslogs for the others Bucket"
}

output "bucket_name_lb_accesslog_bucket" {
  value       = aws_s3_bucket.lb_accesslog.bucket
  description = "Bucket to use for logging the acceslogs for the load balencer"
}

output "bucket_name_archivelog_bucket" {
  value       = aws_s3_bucket.archivelog.bucket
  description = "Bucket to use for archive all the custom logs"
}

output "arn_archivelog_bucket" {
  value       = aws_iam_policy.s3_logs_archive.arn
  description = "Policy to use for archive all the custom logs"
}

output "hosted_zone_id" {
  value       = data.aws_route53_zone.main.zone_id
  description = "Bucket to use for archive all the custom logs"
}

# Security

output "sg_public_web_lb" {
  value       = aws_security_group.public_web_lb.id
  description = "Security group to use for public web application"
}

output "sg_access_to_internet" {
  value       = aws_security_group.access_to_internet.id
  description = "Security group to use to access to Internet"
}
