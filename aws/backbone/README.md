# AWS backbone terraform module

# AWS helper terraform module

This module sets up a typical AWS backbone base infrastructure.

## Arguments

- `azs_count` (string, OPT) - amount of availability zones requested
  - default: total amount of availability zones in the current region

- `nat_type` (string, OPT) - type of NAT, can be 'none', 'single' or 'multi'
  - default: single

- `private_subnets` (list of maps, REQ) - list of private subnets: each one
  takes a `name` and a `base_cidr`
  - default: empty

- `public_subnets` (list of maps, REQ) - list of public subnets: each one takes
   a `name` and a `base_cidr`
  - default: empty

- `region` (string, REQ) - the AWS region
  - default: empty

- `tags` (map, REQ) - tags list
  - default: empty

- `vpc_cidr` (string, REQ) - VPC CIDR block
  - default: empty

## Outputs

None.

## Known issues

Currently passing both a private and a public subnet is required.
