resource "aws_instance" "DockerHost" {
  ami                         = "${data.aws_ami.centos_ami.id}"
  instance_type               = "${var.hon_instance_type}"
  key_name                    = "${var.ec2_keypair_name}"
  vpc_security_group_ids      = ["${aws_security_group.allow_jenkins.id}", "${aws_security_group.outbound_anywhere.id}", "${aws_security_group.world_to_ssh.id}"]
  subnet_id                   = "${module.VPC.public_subnets[0]}"
  associate_public_ip_address = true
  user_data                   = "${data.template_file.default-userdata.rendered}"

  root_block_device {
    delete_on_termination = true
  }

  tags {
    Name        = "DockerHost"
    Environment = "${local.environment}"
    Purpose     = "HoN DevOps walkthrough"
    Link        = "http://www.herd-of-neurons.com/DevOps_Walkthrough_1"
  }
}
