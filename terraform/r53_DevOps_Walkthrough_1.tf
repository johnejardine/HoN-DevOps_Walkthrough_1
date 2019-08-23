resource "aws_route53_record" "jenkins" {
  zone_id = "${data.aws_route53_zone.HON_Sandbox.zone_id}"
  name    = "jenkins.${data.aws_route53_zone.HON_Sandbox.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.DockerHost.public_ip}"]
}

resource "aws_route53_record" "docker" {
  zone_id = "${data.aws_route53_zone.HON_Sandbox.zone_id}"
  name    = "docker.${data.aws_route53_zone.HON_Sandbox.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.DockerHost.public_ip}"]
}
