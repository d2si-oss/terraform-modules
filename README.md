# Terraform Modules

This repository holds modules for the [terraform](https://www.terraform.io) IaC
tool. They are arranged by providers type (e.g. `aws`, `gcp`...). The root of the
repository contains sample stacks exercising some of these modules.

## Common guidelines

* only specify resource attributes which aren't default
* no need to declare the variable type when it's a string
* module name separator: `-` (dash)
* variable name separator: `_` (underscore)

## Prerequisites

* [Terraform](https://www.terraform.io) >= 0.10.3

## Examples

### AWS

* [Backbone](examples/aws/backbone/README.md): Module to create your network stack

### GCP

* [Backbone](examples/gcp/backbone/README.md): Module to create your network stack

## TODO

### AWS

- [ ] Tags
- [ ] SSH Bastion host
- [ ] NACL
- [ ] DHCP option set
- [ ] DNS
- [ ] VPC flow log
- [ ] IPsec VPN (connect multiple regions and/or on-prem)
- [ ] OpenVPN

### GCP

- [ ] SSH Bastion host
- [ ] Make firewall rule allowing traffic through NAT gateway user-configurable
