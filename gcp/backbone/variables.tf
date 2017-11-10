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
  description = "A map of keys (names) and values (CIDR blocks) defining subnetworks"
  type        = "map"
}

variable "subnetwork_private_ip_google_access" {
  default = true
  description = "Whether the VMs in subnets can access Google services without assigned external IP addresses"
}

variable "local_firewall_source_ranges" {
  default = ["10.0.0.0/16"]
  description = "A list of source CIDR ranges that this firewall applies to"
  type = "list"
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

variable "nat_gateway_iptables" {
  description = "A set of instructions (one per line) used as metadata script and defining the iptables routing configuration"
  default = <<EOF
iptables -t nat -A POSTROUTING -j MASQUERADE
EOF
}
