#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-097d9235
#
# Your security group ID is:
#
#     sg-74a4d00e
#
# Your AMI ID is:
#
#     ami-db24d8b6
#
# Your Identity is:
#
#     velocity-c20ad4d76fe97759aa27a0c99bff6710
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-db24d8b6"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-097d9235"
  vpc_security_group_ids = ["sg-74a4d00e"]
  count			 = "2"

  tags {
    Identity = "velocity-c20ad4d76fe97759aa27a0c99bff6710"
    Foo      = "Bar"
    Moo      = "boo"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}
output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
