# GCP backbone Terraform module

This module sets up a GCP backbone base infrastructure featuring:

* a [VPC network][0]
* \# subnetworks
* an optional NAT gateway

## Arguments

See file [variables.tf](variables.tf) for the complete and up-to-date list of variables and their default values.

## Outputs

See file [outputs.tf](outputs.tf) for the complete and up-to-date list of outputs.

## Notes

The *NAT gateway* GCE instance is created only if a destination subnet is specified (see variables). When a NAT gateway is created, the following resources will also be created:

* a dedicated subnet for the NAT gateway instance
* a [static external IP address][1] attached to the NAT gateway instance
* a [VPC network route][2] targeting GCE instances with the label `nated`
* a firewall rule allowing all traffic from NATed instance to the NAT gateway instance


[0]: https://cloud.google.com/compute/docs/vpc/
[1]: https://cloud.google.com/compute/docs/ip-addresses/#reservedaddress
[2]: https://cloud.google.com/compute/docs/vpc/routes
