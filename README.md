# Terraform Modules

This repository holds modules for the [terraform](https://www.terraform.io) IaC
tool. They are arranged by providers type (e.g. aws, google...). The root of the
repository contains sample stacks exercising some of these modules.

## Common guidelines

* only specify resource attributes which aren't default
* no need to declare the variable type when it's a string
* module name separator: `-` (dash)
* variable name separator: `_` (underscore)

## TODO

### AWS

- [ ] Tags
- [ ] SSH Bastion host
- [ ] RDP Bastion host
- [ ] NACL
- [ ] DHCP option set
- [ ] DNS
- [ ] VPC flow log
- [ ] IPsec VPN (connect multiple regions and/or on-prem)
- [ ] OpenVPN
