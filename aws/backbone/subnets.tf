resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${var.tags}"
}

resource "aws_subnet" "public" {
  count  = "${length(local.azs) * length(var.public_subnet_blocks)}"
  vpc_id = "${aws_vpc.main.id}"

  # XXX TODO - Explain this block
  cidr_block = "${cidrsubnet(element(var.public_subnet_blocks,count.index / length(local.azs) ),
                                  ceil(log(length(local.azs),2)),
                                  count.index % length(local.azs)
                                )}"

  availability_zone       = "${local.azs[count.index % length(local.azs)]}"
  map_public_ip_on_launch = "true"

  tags = "${merge(var.tags,
                  map("Name", length(var.public_subnet_names)==0 ?
                                "public-${count.index / length(local.azs)}" :
                                element(concat(var.public_subnet_names,list("")),count.index / length(local.azs)))) }"
}

resource "aws_subnet" "private" {
  count  = "${length(local.azs) * length(var.private_subnet_blocks)}"
  vpc_id = "${aws_vpc.main.id}"

  # XXX TODO - Explain this block
  cidr_block = "${cidrsubnet(element(var.private_subnet_blocks, count.index / length(local.azs) ),
                                  ceil(log(length(local.azs),2)),
                                  count.index % length(local.azs)
                                )}"

  availability_zone = "${local.azs[count.index % length(local.azs)]}"

  tags = "${merge(var.tags,
                  map("Name", length(var.private_subnet_names)==0 ?
                                "private-${count.index / length(local.azs)}" :
                                element(concat(var.private_subnet_names,list("")),count.index / length(local.azs)))) }"
}
