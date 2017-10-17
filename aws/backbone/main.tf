provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "available" {}

locals {
  # Returns a list of availability zone names which length is the of the available zones
  # or the minimum between the user provided one & available zones length.
  # This ensures to always have a valid number of availability zone names.
  azs = "${slice(data.aws_availability_zones.available.names, 0, (var.azs_count == 0 
    ? length(data.aws_availability_zones.available.names) 
    : min(var.azs_count,length(data.aws_availability_zones.available.names))) )}"
}
