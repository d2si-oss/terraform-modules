#
# Configuration
#

#terraform {
#  backend "s3" {}
#}

#
# Variables
#

variable "private_subnet_blocks" {
  type = "list"

  default = [
      "10.0.64.0/20",
      "10.0.96.0/20"
  ]
}

variable "public_subnet_names" {
  type = "list"

  default = [
      "DMZ",
      "Load-balancers"
  ]
}

variable "public_subnet_blocks" {
  type = "list"

  default = [
      "10.0.0.0/20",
      "10.0.32.0/20"
  ]
}

variable "region" {
  default = "eu-west-2"
}

variable "tags" {
  type = "map"

  default = {
    Name        = "myvpc"
    Environment = "test"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

#
# Ressources
#

module "backbone" {
  source          = "github.com/d2si-oss/terraform-modules//aws/backbone"
  region          = "${var.region}"
  vpc_cidr        = "${var.vpc_cidr}"
  public_subnet_blocks  = "${var.public_subnet_blocks}"
  public_subnet_names  = "${var.public_subnet_names}"
  private_subnet_blocks = "${var.private_subnet_blocks}"
  tags            = "${var.tags}"
}
