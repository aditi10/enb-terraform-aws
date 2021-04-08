output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.this.*.id, [""])[0]
}

output "private_subnet_id" {
  description = "List of IDs of private subnets"
 # value       = aws_subnet.private.*.id
#  value = join(",", aws_subnet.private.*.id)
  value       = aws_subnet.private.*.id
  }


output "public_subnet_id" {
  description = "List of IDs of public subnets"
#  value       = aws_subnet.public.*.id
#  value = join(",", aws_subnet.public.*.id)
  value       = aws_subnet.public.*.id
}