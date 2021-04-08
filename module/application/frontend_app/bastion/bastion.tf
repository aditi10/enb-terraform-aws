resource "aws_instance" "bastion-frontend" {
  ami                    = "${var.ami_id}"
#  availability_zone      = "${var.fullaz}"
  availability_zone	 = "${var.bastion_region}"
  count                  = "${var.number_of_instances}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.aws_security_group}"]
  subnet_id              = "${var.subnets}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = "${var.iam}"
  source_dest_check      = false

  tags {
    created_by  = "${lookup(var.tags,"created_by")}"
    Name        = "${var.instance_name}-${format("%03d",count.index)}-${var.env}-${var.az}"
    Environment = "${var.env}"
    Origin           = "${var.origin}"
    Nmonitor         = "true"
  }

}
