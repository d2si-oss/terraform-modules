variable "gcp_project" {}

variable "gcp_region" {
  default = "europe-west1"
}

variable "subnetworks" {
  type        = "map"
  description = "A map of keys (names) and values (CIDR blocks)"
}

variable "subnetwork_private_ip_google_access" {
  default = true
}

variable "nat_gateway_subnet" {
  description = "Subnetwork CIDR block in which to create the NAT gateway (will not create NAT gateway if unset)"
  default     = ""
}

variable "network_name" {}

variable "nat_gateway_instance_type" {
  default = "n1-standard-1"
}

variable "nat_gateway_image" {
  default = "debian-cloud/debian-9"
}

variable "nat_gateway_scopes" {
  default = ["userinfo-email", "compute-ro", "storage-ro"]
}
