output "azs" {
  value = "${slice(data.aws_availability_zones.available.names, 0, (var.azs_count == 0 ? length(data.aws_availability_zones.available.names) : min(var.azs_count,length(data.aws_availability_zones.available.names))) - 1)}"
}
