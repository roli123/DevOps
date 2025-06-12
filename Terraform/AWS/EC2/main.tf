terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "s1" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"

  tags = {
    Name = "Server1"
  }
}

resource "aws_instance" "s2" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
 
  tags = {
    Name = "Server2"
  }
}
