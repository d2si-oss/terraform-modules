# GCP module examples

## GCP VPC Single NAT

This creates a network, subnetworks, a NAT Gateway instance & address, route and firewalls.

To run, configure your GCP provider as described in the [documentation](https://www.terraform.io/docs/providers/google/index.html).

Run this example using:

```hcl
module "backbone" {
  source                = "github.com/d2si-oss/terraform-modules//gcp/backbone"
  gcp_project  = "${var.project}"
  network_name = "${var.network_name}"
  subnetworks  = "${var.subnetworks}"
}
```
