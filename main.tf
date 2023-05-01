terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# S3 configuration is called from a separate backend.tf file
terraform {
  backend "s3" {
    path = "backend.tf"
  }
}

resource "aws_iam_user" "iam_user_tf" {
  create_iam_user = true
  name = "iam_user_tf"
  tags = {
    Name = "Terraform User"
  }
  attach_policy_names = [
    "AmazonEC2FullAccess"
  ]
}

resource "aws_iam_user_policy_attachment" "terraform_user_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  user       = aws_iam_user.iam_user_tf.name
}

resource "aws_iam_access_key" "iam_user_tf" {
  user = aws_iam_user.iam_user_tf.name
}

output "access_key" {
  value = aws_iam_access_key.iam_user_tf.id
}

output "secret_key" {
  value = aws_iam_access_key.iam_user_tf.secret
}

# Create a new VPC
resource "aws_vpc" "vpc_tf" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_with_tf"
  }
}

# Create a new subnet in the VPC
resource "aws_subnet" "subnet_tf" {
  vpc_id     = aws_vpc.vpc_tf.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet_with_tf"
  }
}

# Create a new security group for the EC2 instance
resource "aws_security_group" "sg_tf" {
  name_prefix = "sg_tf"
  vpc_id      = aws_vpc.vpc_tf.id

  tags = {
    Name = "sg_with_tf"
  }
# incoming network traffic to a security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a new EC2 instance
resource "aws_instance" "ec2_instance_tf" {
  ami           = "ami-06e833a81a9a13ece"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_tf.id
  vpc_security_group_ids = [aws_security_group.sg_tf.id]

  tags = {
    Name = "ec2_with_tf"
  }
}
