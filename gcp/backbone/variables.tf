variable "gcp_project" {}

variable "gcp_region" {
  default = "europe-west1"
}

variable "subnetwork_private_ip_google_access" {
  default = true
}

variable "network_name" {}
