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
    type        = "list"
    default     = ["10.0.0.0/26", "10.0.0.64/26"]
    description = "" 
}

variable "public_cidr" {
    type        = "list"
    default     = ["10.0.0.128/26", "10.0.0.192/26"]
    description = "" 
}

variable "availability_zones" {
    type        = "list"
    default     = ["eu-west-3a", "eu-west-3b"]
    description =  ""
}


variable "tags" {
    type        = "map"
    default     = {
        Environment = "dev"
        Application = ""
        Domain      = ""
        Phase       = "Build"
        Technicals  = ""
        Contact     = "mohamed.basri@outlook.com"
        Comment     = "Managed by Terraform"
    }
    description =""
}
