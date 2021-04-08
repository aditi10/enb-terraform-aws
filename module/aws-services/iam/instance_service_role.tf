resource "aws_iam_instance_profile" "kafka" {
    name = "kafka-service-${var.env}-role-iam"
    roles = ["${aws_iam_role.kafka_service_role.name}"]
}

resource "aws_iam_role" "kafka_service_role" {
    name = "kafka-service-${var.env}-role"
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
