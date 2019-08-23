resource "aws_security_group" "outbound_anywhere" {
  name        = "OutboundToAnywhere"
  description = "Allow outbound connections to anywhere"
  vpc_id      = "${module.VPC.vpc_id}"

  tags {
    Name        = "Outbound to Anywhere"
    Environment = "${local.environment}"
  }
}

resource "aws_security_group_rule" "outbound_anywhere" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound connections to anywhere"
  security_group_id = "${aws_security_group.outbound_anywhere.id}"
}
