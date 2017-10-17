# AWS module examples

## AWS VPC Single NAT

This creates a VPC, public & private subnets, a NAT Gateway, Route Tables & Associations and a Internet Gateway.

To run, configure your AWS provider as described in the [documentation](https://www.terraform.io/docs/providers/aws/index.html).

Run this example using:

```hcl
module "backbone" {
  source                = "github.com/d2si-oss/terraform-modules//aws/backbone"
  region                = "${var.region}"
  vpc_cidr              = "${var.vpc_cidr}"
  public_subnet_blocks  = "${var.public_subnet_blocks}"
  private_subnet_blocks = "${var.private_subnet_blocks}"
  tags                  = "${var.tags}"
}
```
