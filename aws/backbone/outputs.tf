#output "public_subnets_data" {
#  description = "List of public subnets grouped by name"
#
#  # Each map is made by cutting the subnet ids into smaller chunks.
#  # using this calculation: slice(subnet_ids, from, to).
#  # First map is: slice(subnet_ids, 0, 1 * nb_of_azs)
#  # Second map is: slice(subnet_ids, 1 * nb_of_azs, 2 * nb_of_azs)
#  # Third one would be: slice(subnet_ids, 2 * nb_of_azs, 3 * nb_of_azs)
#  value = [
#    {
#      name       = "Public1"
#      subnet_ids = ["${slice(module.subnet.subnet_ids, 0, 1 * (var.azs_count == 0 ? length(data.aws_availability_zones.available.names) : min(var.azs_count,length(data.aws_availability_zones.available.names))))}"]
#    },
#    {
#      name       = "Public2"
#      subnet_ids = ["${slice(module.subnet.subnet_ids, 1 * (var.azs_count == 0 ? length(data.aws_availability_zones.available.names) : min(var.azs_count,length(data.aws_availability_zones.available.names))), 2 * (var.azs_count == 0 ? length(data.aws_availability_zones.available.names) : min(var.azs_count,length(data.aws_availability_zones.available.names))))}"]
#    },
#  ]
#}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
