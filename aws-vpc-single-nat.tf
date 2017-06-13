#
# Configuration
#

#terraform {
#  backend "s3" {}
#}

#
# Variables
#

variable "public_subnets" {
  type = "list"

  default = [
    {
      name      = "Public1"
      base_cidr = "10.0.0.0/20"
    },
    {
      name      = "Public2"
      base_cidr = "10.0.32.0/20"
    },
  ]
}

variable "private_subnets" {
  type = "list"

  default = [
    {
      name      = "Private1"
      base_cidr = "10.0.64.0/20"
    },
    {
      name      = "Private2"
      base_cidr = "10.0.96.0/20"
    },
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
  source          = "github.com/d2si-oss/terraform-modules//backbone"
  region          = "${var.region}"
  vpc_cidr        = "${var.vpc_cidr}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  tags            = "${var.tags}"
}
