// Output the ID of the RDS instance
output "rds_instance_id" {
  value = "${aws_db_instance.rds-backend.id}"
}

// Output the Address of the RDS instance
output "rds_instance_address" {
  value = "${aws_db_instance.rds-backend.address}"
}

// Output the ID of the Subnet Group
output "subnet_group_id" {
  value = "${aws_db_subnet_group.backend-db-subnet-group.id}"
}

