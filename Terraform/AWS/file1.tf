terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "s1" {
  ami           = "ami-0d682f26195e9ec0f"
  instance_type = "t2.micro"

  tags = {
    Name = "Server1"
  }
}

resource "aws_instance" "s2" {
  ami           = "ami-0d682f26195e9ec0f"
  instance_type = "t2.micro"
 
  tags = {
    Name = "Server2"
  }
}

resource "aws_instance" "s4" {
  ami           = "ami-0d682f26195e9ec0f"
  instance_type = "t2.micro"
 
  tags = {
    Name = "Server4"
  }
}

resource "aws_instance" "s3" {
  ami           = "ami-0d682f26195e9ec0f"
  instance_type = "t2.micro"
 
  tags = {
    Name = "Server3"
  }
}
