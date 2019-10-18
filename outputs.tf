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

output "bucket_name_accesslog_bucket" {
  value       = aws_s3_bucket.accesslog.bucket
  description = "Bucket to use for logging the acceslogs for the others Bucket"
}
