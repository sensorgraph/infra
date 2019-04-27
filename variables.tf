variable "aws_region" {
    type        = "string"
    default     = "eu-west-3"
    description = ""
}

variable "vpc_cidr" {
    type        = "string"
    default     = "10.0.0.0/24"
    description = "" 
}

variable "private_cidr" {
    type        = "string"
    default     = "10.0.0.0/25"
    description = "" 
}

variable "public_cidr" {
    type        = "string"
    default     = "10.0.0.128/25"
    description = "" 
}

variable "tags" {
    type        = "map"
    default     = {}
    description =""
}
