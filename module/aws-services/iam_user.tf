resource "aws_iam_user" "users" {
  name = "${var.name}"
  path = "/"
}

resource "aws_iam_access_key" "users_access_key" {
  user = "${aws_iam_user.user.name}"
}

resource "aws_iam_user_policy" "users_policy" {
  name = "test"
  user = "${aws_iam_user.users.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
