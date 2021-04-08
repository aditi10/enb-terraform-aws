resource "aws_route53_record" "bastion-route-53-private" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.instance_name}-${format("%03d",count.index)}-${var.bastion_region}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_instance.bastion-frontend.private_dns}"]
}

resource "aws_route53_record" "bastion-route-53-public" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.instance_name}-${format("%03d",count.index)}-${var.bastion_region}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_instance.bastion-frontend.public_dns}"]
}
