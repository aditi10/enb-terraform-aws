resource "aws_instance" "this" {
  count = var.instance_count

  ami              = var.ami
  instance_type    = var.instance_type
 # user_data        = var.user_data
 # user_data_base64 = var.user_data_base64
 # subnet_id = length(var.network_interface) > 0 ? null : element(
 #   distinct(compact(concat([var.subnet_id], var.subnet_ids))),
 #   count.index,
  #)
  subnet_id              = element(split(",", var.subnet_id), count.index)
  key_name               = var.key_name
  #monitoring             = var.monitoring
  #get_password_data      = var.get_password_data
  #vpc_security_group_ids = var.vpc_security_group_ids
  #iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address
  #private_ip                  = length(var.private_ips) > 0 ? element(var.private_ips, count.index) : var.private_ip
  #ipv6_address_count          = var.ipv6_address_count
  #ipv6_addresses              = var.ipv6_addresses

  ebs_optimized = var.ebs_optimized

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }
    /*tags {
       		#created_by  	= "${lookup(var.tags,"created_by")}"
       		Name            = var.name
        	#Name	        = "${var.instance_name}-${format("%03d",count.index)}-${var.env}-${element(split(",",var.az_var), count.index)}"
    		#Environment 	= "${var.env}"
     	 }*/
}