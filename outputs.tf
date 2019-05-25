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