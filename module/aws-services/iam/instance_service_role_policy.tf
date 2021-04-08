resource "aws_iam_role_policy" "kafka_service_role_policy"{
    name = "kafka-service-${var.env}-role_policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:AuthorizeSecurityGroupIngress"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
    role = "${aws_iam_role.kafka_service_role.id}"
}
