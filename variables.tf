variable "aws_region" {
    type        = "string"
    default     = "eu-west-3"
    description = "Region to use for create the infrastructure (default: Paris)"
}

variable "vpc_cidr" {
    type        = "string"
    default     = "10.0.0.0/24"
    description = "IP range to use on the VPC (default: 256 IPs)"
}

variable "private_cidr" {
    type        = "list"
    default     = ["10.0.0.0/26", "10.0.0.64/26"]
    description = "The both IPs range used in the private subnet"
}

variable "public_cidr" {
    type        = "list"
    default     = ["10.0.0.128/26", "10.0.0.192/26"]
    description = "The both IPs range useds in the public subnet" 
}

variable "availability_zones" {
    type        = "list"
    default     = ["eu-west-3a", "eu-west-3b"]
    description =  "By default we use only 2 AZs on Paris"
}

variable "tags" {
    type        = "map"
    default     = {
        Environment = "dev"
        Application = "Sensor Graph"
        Contact     = "mohamed.basri@outlook.com"
        Comment     = "Managed by Terraform"
    }
    description = "Default tags to be applied on the infrastructure"
}
