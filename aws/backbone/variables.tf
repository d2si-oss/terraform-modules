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

variable "private_subnet_roles" {
  type    = "list"
  default = []
}

variable "public_subnet_blocks" {
  type    = "list"
  default = []
}

variable "public_subnet_roles" {
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
