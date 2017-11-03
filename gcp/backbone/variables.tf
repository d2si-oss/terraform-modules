variable "gcp_project" {}

variable "gcp_region" {
  default = "europe-west1"
}

variable "subnetwork_private_ip_google_access" {
  default = true
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
