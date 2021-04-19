terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [ aws.region ]
    }
  }
}


data "aws_ami" "ubuntu" { # using filter to avoid specifying ami id for ubuntu in every region
    most_recent = true
    provider = aws.region
    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }

    owners = ["099720109477"] # canonical
}

resource "aws_instance" "webserver" {
    ami           = data.aws_ami.ubuntu.id
    provider = aws.region
    instance_type = "t2.micro"
}

output "instance_id" {
  value = aws_instance.webserver.id
}