resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${var.tags}"
}

module "helper" {
  source    = "../helper"
  azs_count = "${var.azs_count}"
}

resource "aws_subnet" "public" {
  count  = "${length(module.helper.azs) * length(var.public_subnets)}"
  vpc_id = "${aws_vpc.main.id}"

  # XXX TODO - Explain this block
  cidr_block = "${cidrsubnet(lookup(var.public_subnets[ count.index / length(module.helper.azs) ],"base_cidr"),
                                  ceil(log(length(module.helper.azs),2)),
                                  count.index % length(module.helper.azs)
                                )}"

  availability_zone       = "${module.helper.azs[count.index % length(module.helper.azs)]}"
  map_public_ip_on_launch = "true"

  tags = "${var.tags}"
}

resource "aws_subnet" "private" {
  count  = "${length(module.helper.azs) * length(var.private_subnets)}"
  vpc_id = "${aws_vpc.main.id}"

  # XXX TODO - Explain this block
  cidr_block = "${cidrsubnet(lookup(var.private_subnets[ count.index / length(module.helper.azs) ],"base_cidr"),
                                  ceil(log(length(module.helper.azs),2)),
                                  count.index % length(module.helper.azs)
                                )}"

  availability_zone = "${module.helper.azs[count.index % length(module.helper.azs)]}"

  tags = "${var.tags}"
}
