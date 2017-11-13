# AWS backbone terraform module

This module sets up an AWS backbone base infrastructure.

## Arguments

- `azs_count` (string)

  Amount of availability zones requested.
  - default: amount of AZs in the current region

- `nat_type` (string)

  Type of NAT, can be `none` (no NAT), `single` (one NAT gateway) or `multi`
  (one NAT gateway per AZ).
  - default: "single"

- `private_subnet_blocks` (list)

  List of private subnet blocks. Each subnet CIDR will be computed based on this
  variable and `azs_count`.
  - default: none

- `private_subnet_names` (list)

  List of private subnet names (matching `private_subnet_blocks` ordering).
  - default: private-${count.index}

- `public_subnet_blocks` (list)

  List of public subnet blocks. Each subnet CIDR will be computed based on this
  variable and `azs_count`.
  - default: none

- `public_subnet_names` (list)

  List of public subnet names (matching `public_subnet_blocks` ordering).
  - default: public-${count.index}

- `region` (string)

  AWS region.
  - default: none

- `tags` (map)

  Tags list.
  - default: none

- `vpc_cidr` (string)

  VPC CIDR block.
  - default: none

- `vgw_id` (string)

  Id ot the virtual gateway to attach to the VPC (`""`: no VGW)
  - default: ""

- `vgw_prop` (string)

  Propagation of routes configured on the VGW, can be `none` (no propagation),
  `all` (propagate to all subnets), `private` (propagate only for private subnets)
  - default: "all"


## Outputs

- `private_subnets_cidr` - CIDR of private subnets
- `private_subnets_id` - Id of private subnets
- `public_subnets_cidr` - CIDR of public subnets
- `public_subnets_id` - Id public subnets
- `vpc_cidr` - CIDR of the VPC
- `vpc_id` - Id of the VPC
