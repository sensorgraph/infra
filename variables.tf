variable "aws_region" {
  type        = "string"
  description = "Region to use for create the infrastructure (default: Paris)"
  default     = "eu-west-3"
}

variable "vpc_cidr" {
  type        = "string"
  description = "IP range to use on the VPC (default: 256 IPs)"
  default     = "10.0.0.0/24"
}

variable "private_cidr" {
  type        = "list"
  description = "The both IPs range used in the private subnet"
  default     = ["10.0.0.0/26", "10.0.0.64/26"]
}

variable "public_cidr" {
  type        = "list"
  description = "The both IPs range useds in the public subnet" 
  default     = ["10.0.0.128/26", "10.0.0.192/26"]
}

variable "availability_zones" {
  type        = "list"
  description =  "By default we use only 2 AZs on Paris"
  default     = ["eu-west-3a", "eu-west-3b"]
}

variable "tags" {
  type        = "map"
  description = "Default tags to be applied on the bastion infrastructure"
  default     = {
      "Billing:Organisation"     = "Kibadex"
      "Billing:OrganisationUnit" = "Kibadex Labs"
      "Billing:Application"      = "All"
      "Billing:Environment"      = "Prod"       
      "Billing:Contact"          = "mohamed.basri@outlook.com"
      "Technical:Terraform"      = "True"
      "Technical:Version"        = "1.0.0"
      #"Technical:Comment"        = "Managed by Terraform"
      #"Security:Compliance"      = "HIPAA"
      #"Security:DataSensitity"   = "1"
      #"Security:Encryption"      = "True"
  }
}

variable "name" {
  type        = "map"
  description = "Default tags name to be applied on the infrastructure for the resources names"
  default     = {
    Environment      = "prd"
    Organisation     = "kbd"
    OrganisationUnit = "lab"
  }
}