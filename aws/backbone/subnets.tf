resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${var.tags}"
}

module "helper" {
  source    = "github.com/d2si-oss/terraform-modules//aws/helper"
  azs_count = "${var.azs_count}"
}

resource "aws_subnet" "public" {
  count  = "${length(module.helper.azs) * length(var.public_subnet_blocks)}"
  vpc_id = "${aws_vpc.main.id}"

  # XXX TODO - Explain this block
  cidr_block = "${cidrsubnet(element(var.public_subnet_blocks,count.index / length(module.helper.azs) ),
                                  ceil(log(length(module.helper.azs),2)),
                                  count.index % length(module.helper.azs)
                                )}"

  availability_zone       = "${module.helper.azs[count.index % length(module.helper.azs)]}"
  map_public_ip_on_launch = "true"

  tags = "${merge(var.tags,
                  map("Name", length(var.public_subnet_names)==0 ? 
                                "public-${count.index / length(module.helper.azs)}-${module.helper.azs[count.index % length(module.helper.azs)]}" :
                                "${element(concat(var.public_subnet_names,list("")),count.index / length(module.helper.azs))}-${module.helper.azs[count.index % length(module.helper.azs)]}")) }"
}

resource "aws_subnet" "private" {
  count  = "${length(module.helper.azs) * length(var.private_subnet_blocks)}"
  vpc_id = "${aws_vpc.main.id}"

  # XXX TODO - Explain this block
  cidr_block = "${cidrsubnet(element(var.private_subnet_blocks, count.index / length(module.helper.azs) ),
                                  ceil(log(length(module.helper.azs),2)),
                                  count.index % length(module.helper.azs)
                                )}"

  availability_zone = "${module.helper.azs[count.index % length(module.helper.azs)]}"

  tags = "${merge(var.tags,
                  map("Name", length(var.private_subnet_names)==0 ? 
                                "private-${count.index / length(module.helper.azs)}-${module.helper.azs[count.index % length(module.helper.azs)]}" :
                                "${element(concat(var.private_subnet_names,list("")),count.index / length(module.helper.azs))}-${module.helper.azs[count.index % length(module.helper.azs)]}")) }"
}
