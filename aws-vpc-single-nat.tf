#
# Configuration
#

#terraform {
#  backend "s3" {}
#}

#
# Variables
#

variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  region = "${var.region}"
}

variable "private_subnet_blocks" {
  type = "list"

  default = [
    "10.0.64.0/20",
    "10.0.96.0/20",
  ]
}

variable "public_subnet_roles" {
  type = "list"

  default = [
    "DMZ",
    "Load-balancers",
  ]
}

variable "public_subnet_blocks" {
  type = "list"

  default = [
    "10.0.0.0/20",
    "10.0.32.0/20",
  ]
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
  source                = "github.com/d2si-oss/terraform-modules//aws/backbone"
  region                = "${var.region}"
  vpc_cidr              = "${var.vpc_cidr}"
  public_subnet_blocks  = "${var.public_subnet_blocks}"
  public_subnet_roles   = "${var.public_subnet_roles}"
  private_subnet_blocks = "${var.private_subnet_blocks}"
  tags                  = "${var.tags}"
}

data "aws_vpc" "backbone" {
  depends_on = ["module.backbone"]
  id         = "${module.backbone.vpc_id}"
}

data "aws_subnet_ids" "dmz" {
  # we have to depend on the whole because subnets are create after the VPC
  # if you create the VPC in a separate stack and use remote state you don't need this dependency
  depends_on = ["module.backbone"]

  vpc_id = "${module.backbone.vpc_id}"

  tags {
    Role = "DMZ"
  }
}

data "aws_subnet_ids" "loadbalancers" {
  depends_on = ["module.backbone"]
  vpc_id     = "${module.backbone.vpc_id}"

  tags {
    Role = "Load-balancers"
  }
}

data "aws_subnet_ids" "private1" {
  depends_on = ["module.backbone"]
  vpc_id     = "${module.backbone.vpc_id}"

  tags {
    Role = "private-0"
  }
}

data "aws_subnet_ids" "private2" {
  depends_on = ["module.backbone"]
  vpc_id     = "${module.backbone.vpc_id}"

  tags {
    Role = "private-1"
  }
}

output "vpc_cidr" {
  value = "${data.aws_vpc.backbone.cidr_block}"
}

output "dmz_subnets" {
  value = "${data.aws_subnet_ids.dmz.ids}"
}

output "loadbalancers_subnets" {
  value = "${data.aws_subnet_ids.loadbalancers.ids}"
}

output "private1_subnets" {
  value = "${data.aws_subnet_ids.private1.ids}"
}

output "private2_subnets" {
  value = "${data.aws_subnet_ids.private2.ids}"
}
