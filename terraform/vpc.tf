# This file provisions the temporary VPC & Subnet
# This has been kept simple: 1 AZ and 1 Subnet

locals {
  azs = ["ca-central-1a"]
}

module "VPC" {
  source = "modules/vpc/"

  vpc_name = "${local.environment}"
  vpc_cidr = "${local.vpc_cidr}"

  azs = "${local.azs}"

  public_subnets = ["${lookup(local.subnet_cidr_blocks, "hon_subnet_1")}"]

  enable_dns_support               = true
  enable_dns_hostnames             = true
  dhcp_options_domain_name_servers = ["127.0.0.1", "AmazonProvidedDNS"]

  tags = {
    Environment = "${local.environment}"
  }
}
