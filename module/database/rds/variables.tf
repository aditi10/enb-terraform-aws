variable "env" {}

variable "rds_instance_name" {}



variable "rds_is_multi_az" {
  default = "true"
}

variable "rds_storage_type" {
  default = "standard"
}
#variable "skip_final_snapshot" {}
variable "database_name" {}
variable "small_az_replica" {}
variable "rds_engine_version" {}
variable "db_type_replica" {}
variable "rds_replica_instance_name" {}

variable "rds_allocated_storage" {
  description = "The allocated storage in GBs"

  // You just give it the number, e.g. 10
}

variable "allocated_storage" {}

variable "rds_instance_class" {}
/*
variable "snapshot_identifier" {}

variable "license_model" {}
*/

variable "password" {}
variable "username" {}
variable "engine" {}


variable "rds_security_group_id" {
  description = ""
}

variable "db_parameter_group" {}
#variable "subnets" {}


variable "subnets" {
  description = ""
  type = "list"
}


variable "azs" {}

variable "small_az" {}



variable "db_parameter_group_family" {}

variable "db_type" {}



variable "origin" {}

variable "multi_az" {}

#variable "kms_key_id" {}

variable "identifier" {}

