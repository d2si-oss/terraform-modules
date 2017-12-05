variable "azs_count" {
  description = "Number of Availability Zones; 0 = use all AZs; maxed out at region's AZs"
  default     = 0
}

variable "nat_type" {
  type        = "string"
  description = "Can be 'none', 'single' or 'multi'"
  default     = "single"
}

variable "private_subnet_blocks" {
  type    = "list"
  default = []
}

variable "private_subnet_names" {
  type    = "list"
  default = []
}

variable "public_subnet_blocks" {
  type    = "list"
  default = []
}

variable "public_subnet_names" {
  type    = "list"
  default = []
}

variable "region" {
  description = "AWS Region"
}

variable "tags" {
  description = "Tags list"
  type        = "map"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
}

variable "vgw_id" {
  description = "ID of a Virtual Gateway (VGW) to attach to the VPC. No attachment if empty"
  type        = "string"
  default     = ""
}

variable "vgw_prop" {
  description = "Propagate Virtual Gateway (VGW) routes; all= public and private subnets; private= private subnets only; none= no propagation"
  type        = "string"
  default     = "all"
}
