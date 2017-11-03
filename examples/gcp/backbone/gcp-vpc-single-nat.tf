variable "subnetworks" {
  type = "map"

  default = {
    front = "10.0.0.0/24"
    back  = "10.0.1.0/24"
  }
}

module "backbone" {
  source             = "github.com/d2si-oss/terraform-modules//gcp/backbone"
  gcp_project        = "myproject"
  network_name       = "mynetwork"
  subnetworks        = "${var.subnetworks}"
  nat_gateway_subnet = "front"
}
