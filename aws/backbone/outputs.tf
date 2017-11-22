output "private_subnets_cidr" {
  description = "List of private subnets CIDR"
  value       = ["${aws_subnet.private.*.cidr_block}"]
}

output "private_subnets_id" {
  description = "List of private subnets id"
  value       = ["${aws_subnet.private.*.id}"]
}

output "public_subnets_cidr" {
  description = "List of public subnets CIDR"
  value       = ["${aws_subnet.public.*.cidr_block}"]
}

output "public_subnets_id" {
  description = "List of public subnets id"
  value       = ["${aws_subnet.public.*.id}"]
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = "${aws_vpc.main.cidr_block}"
}

output "vpc_id" {
  description = "VPC id"
  value       = "${aws_vpc.main.id}"
}
