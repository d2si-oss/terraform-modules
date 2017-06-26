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

  List of private subnets: each one takes a `name` and a `base_cidr`.  
  Each subnet CIDR will be computed based on the `base_cidr` and `azs_count`.
  - default: none

- `public_subnet_blocks` (list)

  List of public subnets each one takes a `name` and a `base_cidr`.  
  Each subnet CIDR will be computed based on the `base_cidr` and `azs_count`.
  - default: none

- `region` (string)

  AWS region.
  - default: none

- `tags` (map)

  Tags list.
  - default: none

- `vpc_cidr` (string)

  VPC CIDR block.
  - default: none

## Outputs

None.

## Known issues

Currently passing both a private and a public subnet is required.
