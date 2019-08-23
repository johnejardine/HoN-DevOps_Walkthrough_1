resource "aws_security_group" "allow_jenkins" {
  name        = "allow_jenkins_comms"
  description = "Allow external http traffic"
  vpc_id      = "${module.VPC.vpc_id}"

  tags {
    Name        = "External Jenkins Communications"
    Environment = "${local.environment}"
  }
}

resource "aws_security_group_rule" "world_to_Jenkins" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  description       = "Jenkins HTTP Protocol - TCP"
  security_group_id = "${aws_security_group.allow_jenkins.id}"
}
