#
# Public Route Table
#

resource "aws_internet_gateway" "public" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${var.tags}"
}

resource "aws_route_table" "public" {
  count  = "${length(var.public_subnet_blocks) == 0 ? 0 : 1}"
  tags   = "${var.tags}"
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(local.azs) * length(var.public_subnet_blocks)}"
  subnet_id      = "${element(aws_subnet.public.*.id,count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

#
# Private route table - Standalone
#

resource "aws_route_table" "private_standalone" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "none" ? 1 : 0}"

  tags   = "${var.tags}"
  vpc_id = "${aws_vpc.main.id}"
}

#
# Private route table - Single NAT Gateway for all Availability Zones
#

resource "aws_route_table" "private_single" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "single" ? 1 : 0}"

  tags   = "${var.tags}"
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_eip" "private_single" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "single" ? 1 : 0}"

  vpc = true
}

resource "aws_nat_gateway" "private_single" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "single" ? 1 : 0}"

  allocation_id = "${aws_eip.private_single.id}"

  # XXX TODO - Explain which subnet to use. In our case the subnet is the first
  # element of the 6 available, which is related to Public1.

  # Workaround to avoid error "element() may not be used with an empty list, even if count for resource is 0"
  subnet_id = "${length(var.private_subnet_blocks) == 0 ? "" : element(concat(aws_subnet.public.*.id,list("")),0)}"
}

resource "aws_route" "private_single" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "single" ? 1 : 0}"

  route_table_id         = "${aws_route_table.private_single.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.private_single.id}"
}

resource "aws_route_table_association" "private_single" {
  count = "${(length(var.private_subnet_blocks) != 0 && var.nat_type == "single" ? length(var.private_subnet_blocks) * length(local.azs) : 0)}"

  subnet_id      = "${element(aws_subnet.private.*.id,count.index)}"
  route_table_id = "${aws_route_table.private_single.id}"
}

#
# Private route table - One NAT gateway per Availability Zone
#

resource "aws_route_table" "private_multi" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "multi" ? length(local.azs) : 0}"

  tags   = "${var.tags}"
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_eip" "private_multi" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "multi" ? length(local.azs) : 0}"

  vpc = true
}

resource "aws_nat_gateway" "private_multi" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "multi" ? length(local.azs) : 0}"

  allocation_id = "${aws_eip.private_multi.*.id[count.index]}"

  # XXX TODO - Explain which subnet to use. In our case the subnet is the first
  # element of the 6 available, which is related to Public1.
  subnet_id = "${aws_subnet.public.*.id[count.index]}"
}

resource "aws_route" "private_multi" {
  count = "${length(var.private_subnet_blocks) != 0 && var.nat_type == "multi" ? length(local.azs) : 0}"

  route_table_id         = "${aws_route_table.private_multi.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.private_multi.*.id[count.index]}"
}

resource "aws_route_table_association" "private_multi" {
  count = "${(length(var.private_subnet_blocks) != 0 && var.nat_type == "multi" ? length(var.private_subnet_blocks) * length(local.azs) : 0)}"

  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private_multi.*.id[count.index % length(local.azs)]}"
}
