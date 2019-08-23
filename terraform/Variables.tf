locals {
  environment = "AWSDockerJenkinsGitHub"

  # The region local is required to use in some resources that fail when using the "aws_region" datasource resource
  region = "ca-central-1"

  centos7_latest_ami = "${data.aws_ami.centos_ami.id}"
  vpc_cidr           = "172.20.0.0/16"

  vpc_cidr_blocks = {
    HON_Sandbox = "${cidrsubnet(local.vpc_cidr, 4, 0)}"
  }

  subnet_cidr_blocks = {
    hon_subnet_1 = "${cidrsubnet(lookup(local.vpc_cidr_blocks, "HON_Sandbox"), 4, 1)}"
  }
}

data "aws_ami" "centos_ami" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "description"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA*"]
  }
}

data "template_file" "default-userdata" {
  template = "${file("${path.cwd}/files/default-userdata.bash")}"
}

variable "hon_instance_type" {
  default = "t3.medium"
}

variable "ec2_keypair_name" {
  default = "HoN_DevOps_Walkthrough_1"
}

data "aws_route53_zone" "HON_Sandbox" {
  name         = "myscratchpad.ca."
  private_zone = false
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
