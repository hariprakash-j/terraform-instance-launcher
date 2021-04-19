terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.27"
        }
    }
}

# regions in aws
provider "aws" {
    alias = "mumbai"
    region = "ap-south-1"
}
provider "aws" {
    alias = "us"
    region  = "us-west-2"
}
provider "aws" {
    alias = "singapore"
    region  = "ap-southeast-1"
}

module "ec2_instance" {
    source = "./modules/ec2"
    providers = {
        aws.region = aws.us
    }

}