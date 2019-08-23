output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${element(concat(aws_vpc.HoN_sandbox.*.id, list("")), 0)}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${element(concat(aws_vpc.HoN_sandbox.*.cidr_block, list("")), 0)}"
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = "${concat(aws_subnet.public.*.id, list())}"
}

output "public_subnet_cidrs" {
  description = "List of IP CIDRs of public subnets"
  value       = ["${var.public_subnets}"]
}

output "azs" {
  description = "The list of Subnet IDs that this ASG should be spread over."
  value       = "${var.azs}"
}
