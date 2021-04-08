output "bastion_public_ip" {
  value = "${aws_instance.bastion-frontend.public_ip}"
}
