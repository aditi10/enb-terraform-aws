
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "../../module/network/vpc"

  name = "test-example"

  azs                 = ["eu-west-1a", "eu-west-1b" , "eu-west-1c"]

  cidr = "10.0.0.0/16" # 10.0.0.0/8 is reserved for EC2-Classic
  private_subnets     = ["10.0.1.0/24","10.0.2.0/24"]
  public_subnets      = ["10.0.11.0/24","10.0.12.0/24"]
  public_subnet_suffix = "public_subnet"
  private_subnet_suffix = "private_subnet"

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = false

 tags = {
    Owner       = "user"
    Environment = "test"
    Name        = "Vnet-1"
  }
  }


module "vpc2" {
  source = "../../module/network/vpc"

  name = "test-example"

  azs                 = ["eu-west-1a", "eu-west-1b" , "eu-west-1c"]

  cidr = "10.1.0.0/16" # 10.0.0.0/8 is reserved for EC2-Classic
  private_subnets     = ["10.1.1.0/24","10.1.2.0/24"]
  public_subnets      = ["10.1.11.0/24","10.1.12.0/24"]
  public_subnet_suffix = "public_subnet"
  private_subnet_suffix = "private_subnet"

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = false

 tags = {
    Owner       = "user"
    Environment = "test"
    Name        = "Vnet-2"
  }
  }

/*

module "tgw" {
  source = "../../module/network/transit-gateway"

  name            = "my-tgw"
  description     = "My TGW shared with several other AWS accounts"
  amazon_side_asn = 64532

  enable_auto_accept_shared_attachments = true # When "true" there is no need for RAM resources if using multiple AWS accounts

  vpc_attachments = {
    vpc1 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.vpc.private_subnet_id # module.vpc1.private_subnets
      #vpc_id                                          = data.aws_vpc.default.id      # module.vpc1.vpc_id
      #subnet_ids                                      = data.aws_subnet_ids.this.ids # module.vpc1.private_subnets

      dns_support                                     = true
      ipv6_support                                    = false
      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
      #      transit_gateway_route_table_id = "tgw-rtb-073a181ee589b360f"

   #   tgw_routes = [
   #     {
   #       destination_cidr_block = "30.0.0.0/16"
   #     },
   #     {
   #       blackhole              = true
   #       destination_cidr_block = "0.0.0.0/0"
   #     }
   #   ]
    },
    vpc2 = {
      vpc_id     = module.vpc2.vpc_id     # module.vpc2.vpc_id
      subnet_ids = module.vpc2.private_subnet_id # module.vpc2.private_subnets

    #  tgw_routes = [
    #   {
    #      destination_cidr_block = "50.0.0.0/16"
    #    },
    #    {
    #      blackhole              = true
    #      destination_cidr_block = "10.10.10.10/32"
    #    }
    #  ]
    },
  }

  ram_allow_external_principals = true
  ram_principals                = [307990089504]

  tags = {
    Purpose = "tgw-complete-example"
  }
}
*/
/*


module "vpc3" {
  source = "../../module/network/vpc"

  name = "test-example"

  azs                 = ["eu-west-1a", "eu-west-1b" , "eu-west-1c"]

  cidr = "10.2.0.0/16" # 10.0.0.0/8 is reserved for EC2-Classic
  private_subnets     = ["10.2.1.0/24","10.2.2.0/24"]
  public_subnets      = ["10.2.11.0/24","10.2.12.0/24"]
  public_subnet_suffix = "public_subnet"
  private_subnet_suffix = "private_subnet"

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = false

 tags = {
    Owner       = "user"
    Environment = "test"
    Name        = "Vnet-3"
  }
  }
  ##############EC2 INSTANCE ###############

  data "aws_ami" "amazon_linux" {
    most_recent = true

    owners = ["amazon"]

    filter {
      name = "name"
      values = [
        "amzn-ami-hvm-*-x86_64-gp2",
      ]
    }

    filter {
      name = "owner-alias"
      values = [
        "amazon", ]
    }
  }

  module "ec2_amazon_linux" {
      source = "../../module/application/backend_app/amazon_linux"

      instance_count = 1

      name          = "example-amazon_linux"
      ami           = data.aws_ami.amazon_linux.id
      instance_type = "t2.micro"
      subnet_id     = module.vpc.public_subnet_id
      #  private_ips                 = ["172.31.32.5", "172.31.46.20"]
 #     vpc_security_group_ids      = [module.security_group.this_security_group_id]
      associate_public_ip_address = true
      key_name      = "test"
 #     placement_group             = aws_placement_group.web.id

 #     user_data_base64 = base64encode(local.user_data)

      root_block_device = [
        {
          volume_type = "gp2"
          volume_size = 20
        },
      ]

      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp2"
          volume_size = 20
          encrypted   = true
          #kms_key_id  = aws_kms_key.this.arn
        }
      ]

      tags = {
        "Env"      = "bastion"
        "Location" = "Secret"
        "Name"     = "Amazon-linux-1"
      }
    }

module "ec2_amazon_linux_private1" {
      source = "../../module/application/backend_app/amazon_linux"

      instance_count = 1

      name          = "example-amazon_linux"
      ami           = data.aws_ami.amazon_linux.id
      instance_type = "t2.micro"
      subnet_id     = module.vpc.private_subnet_id
      #  private_ips                 = ["172.31.32.5", "172.31.46.20"]
 #     vpc_security_group_ids      = [module.security_group.this_security_group_id]
      associate_public_ip_address = false
      key_name      = "test"
 #     placement_group             = aws_placement_group.web.id

 #     user_data_base64 = base64encode(local.user_data)

      root_block_device = [
        {
          volume_type = "gp2"
          volume_size = 20
        },
      ]

      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp2"
          volume_size = 20
          encrypted   = true
          #kms_key_id  = aws_kms_key.this.arn
        }
      ]

      tags = {
        "Env"      = "test"
        "Location" = "Secret"
        "Name"     = "Amazon-linux-1"
      }
    }

module "ec2_amazon_linux2_private2" {
      source = "../../module/application/backend_app/amazon_linux"

      instance_count = 1

      name          = "example-amazon_linux"
      ami           = data.aws_ami.amazon_linux.id
      instance_type = "t2.micro"
      subnet_id     = module.vpc2.private_subnet_id
      #  private_ips                 = ["172.31.32.5", "172.31.46.20"]
 #     vpc_security_group_ids      = [module.security_group.this_security_group_id]
      associate_public_ip_address = false
      key_name      = "test"
 #     placement_group             = aws_placement_group.web.id

 #     user_data_base64 = base64encode(local.user_data)

      root_block_device = [
        {
          volume_type = "gp2"
          volume_size = 20
        },
      ]

      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp2"
          volume_size = 20
          encrypted   = true
          #kms_key_id  = aws_kms_key.this.arn
        }
      ]

      tags = {
        "Env"      = "test"
        "Location" = "Secret"
        "Name"     = "Amazon-linux-2"
      }
      }


  module "ec2_amazon_linux3_private3" {
      source = "../../module/application/backend_app/amazon_linux"

      instance_count = 1

      name          = "example-amazon_linux"
      ami           = data.aws_ami.amazon_linux.id
      instance_type = "t2.micro"
      subnet_id     = module.vpc3.private_subnet_id
      #  private_ips                 = ["172.31.32.5", "172.31.46.20"]
 #     vpc_security_group_ids      = [module.security_group.this_security_group_id]
      associate_public_ip_address = false
      key_name      = "test"
 #     placement_group             = aws_placement_group.web.id

 #     user_data_base64 = base64encode(local.user_data)

      root_block_device = [
        {
          volume_type = "gp2"
          volume_size = 20
        },
      ]

      ebs_block_device = [
        {
          device_name = "/dev/sdf"
          volume_type = "gp2"
          volume_size = 20
          encrypted   = true
          #kms_key_id  = aws_kms_key.this.arn
        }
      ]

      tags = {
        "Env"      = "test"
        "Location" = "Secret"
        "Name"     = "Amazon-linux-3"
      }
      }


*/