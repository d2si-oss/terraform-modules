variable "region" {}

variable "azs_count" {
  description = "Number of Availability Zones; 0 = use all AZs; maxed out at region's AZs"
  default     = 0
}
