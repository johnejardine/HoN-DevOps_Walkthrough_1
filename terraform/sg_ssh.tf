resource "aws_security_group" "world_to_ssh" {
  name        = "world_ssh_to_instance"
  description = "SSH connection rules"
  vpc_id      = "${module.VPC.vpc_id}"

  tags {
    Name        = "SSH security group"
    Environment = "${local.environment}"
  }
}

resource "aws_security_group_rule" "world_to_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow SSH to any/every instance"
  security_group_id = "${aws_security_group.world_to_ssh.id}"
}
