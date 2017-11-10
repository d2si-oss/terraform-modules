variable "gcp_project" {
  description = "GCP project to create backbone into"
}

variable "gcp_region" {
  description = "GCP region to create backbone into"
  default = "europe-west1"
}

variable "network_name" {
  description = "Name of the VPC network"
}

variable "subnetworks" {
  description = "A map of keys (names) and values (CIDR blocks)"
  type        = "map"
}

variable "subnetwork_private_ip_google_access" {
  default = true
}

variable "nat_gateway_subnet" {
  description = "Subnetwork CIDR block in which to create the NAT gateway (will not create NAT gateway if unset)"
  default     = ""
}

variable "nat_gateway_instance_type" {
  description = "GCE instance type to use for NAT gateway"
  default     = "n1-standard-1"
}

variable "nat_gateway_image" {
  description = "GCE instance image to use for NAT gateway"
  default     = "debian-cloud/debian-9"
}
