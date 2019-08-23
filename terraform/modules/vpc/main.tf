# VPC for RDS Sandbox #
# An Internet Gateway must exist
# Two, or more, subnets must exist
#######
resource "aws_vpc" "HoN_sandbox" {
  count = "${length(var.vpc_cidr) > 0 ? 1 : 0}"

  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags = "${merge(var.tags, map("Name", format("%s", var.vpc_name)))}"
}

resource "aws_vpc_dhcp_options" "HoN_sandbox" {
  domain_name_servers = ["${var.dhcp_options_domain_name_servers}"]
}

resource "aws_vpc_dhcp_options_association" "HoN_sandbox" {
  vpc_id          = "${aws_vpc.HoN_sandbox.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.HoN_sandbox.id}"
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = "${aws_vpc.HoN_sandbox.id}"
  tags   = "${merge(var.tags, map("Name", "Internet_gateway"), map("Purpose", "Internet gateway"))}"
}

resource "aws_subnet" "public" {
  count = "${length(var.public_subnets) > 0 ? length(var.public_subnets) : 0}"

  vpc_id                  = "${aws_vpc.HoN_sandbox.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags                    = "${merge(var.tags, map("Name", "HoN sandbox public subnet ${count.index}"), map("Purpose", "Public subnet ${var.public_subnets[count.index]}"))}"
}

# Create a route table for use with public subnets.
# - One route points to VPC CIDR
# - Default route points to IGW
resource "aws_route_table" "public_route_table" {
  count  = "${length(var.public_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.HoN_sandbox.id}"
  tags   = "${merge(var.tags, map("Name", "Public Route Table"), map("Purpose", "Public Route Table"))}"
}

resource "aws_route" "PublicDefaultRoute" {
  count                  = "${length(var.public_subnets) > 0 ? 1 : 0}"
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gw.id}"
}

resource "aws_route_table_association" "public_rta" {
  count = "${length(var.public_subnets) > 0 ? length(var.public_subnets) : 0}"

  # subnet_id      = "${aws_subnet.public.id}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
