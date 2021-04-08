provider "aws" {
        region	= "eu-west-1"
        #profile = "enbd"

}


terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-ad"
    key            = "terraform.tfstate"
    encrypt        = true


    }
    }
