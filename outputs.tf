output "availability_zones" {
  value       = var.availability_zones
  description = "The AZs to be used on the infrastructure"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of main VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public.*.id
  description = "The IDs of public subnets"
}

output "private_subnet_id" {
  value       = aws_subnet.private.*.id
  description = "The IDs of private subnets"
}

output "bucket_name_accesslog_bucket" {
  value       = aws_s3_bucket.accesslog.bucket
  description = "Bucket to use for logging the acceslogs for the others Bucket"
}

output "test" {
  value = cidrsubnets("10.0.0.0/24", 2, 2, 2, 2)
}

output "test1" {
  value = cidrsubnet("10.0.0.0/24", 2, 1)
}
