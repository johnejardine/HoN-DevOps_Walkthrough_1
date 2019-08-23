variable "aws_region" {
  description = "The region where AWS operations will take place. Examples are us-east-1, us-west-2, etc."
  default     = ""
}

variable "vpc_name" {
  description = "Name to be used on all the VPC resources as identifier"
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "A list of DNS Servers to use"
  default     = []
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "azs" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  default     = {}
}

variable "nat_gw_id" {
  description = "ID of the NAT Gateway"
  default     = ""
}

variable "public_subnet_1_cidr" {
  description = "The CIDR used by the 1st public subnet"
  default     = ""
}
