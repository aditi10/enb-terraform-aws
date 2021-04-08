output "aws_iam_instance_profile_bastion_id" {
        value = "${aws_iam_instance_profile.bastion.id}" 
}

output "aws_iam_instance_profile_nginx_id" {
        value = "${aws_iam_instance_profile.nginx.id}" 
}

output "aws_iam_instance_profile_kafka_id" {
        value = "${aws_iam_instance_profile.kafka.id}" 
}

output "aws_iam_instance_profile_mysql_id" {
        value = "${aws_iam_instance_profile.mysql.id}" 
}

output "aws_iam_instance_profile_memsql_id" {
        value = "${aws_iam_instance_profile.memsql.id}" 
}

output "aws_iam_instance_profile_jenkins_id" {
        value = "${aws_iam_instance_profile.jenkins.id}" 
}

output "aws_iam_instance_profile_mediation_server_id" {
        value = "${aws_iam_instance_profile.mediation_server.id}" 
}

output "aws_iam_instance_profile_consumer_id" {
        value = "${aws_iam_instance_profile.consumer.id}" 
}

output "aws_iam_instance_profile_priority_Engine_id" {
        value = "${aws_iam_instance_profile.priority_Engine.id}" 
}

output "aws_iam_instance_profile_publisher_portal_id" {
        value = "${aws_iam_instance_profile.publisher_portal.id}" 
}

output "aws_iam_instance_profile_stat_server_id" {
        value = "${aws_iam_instance_profile.stat_server.id}" 
}

output "aws_iam_instance_profile_tracking_server_id" {
        value = "${aws_iam_instance_profile.tracking_server.id}" 
}

output "aws_iam_instance_profile_zookeeper_id" {
        value = "${aws_iam_instance_profile.zookeeper.id}"
}
