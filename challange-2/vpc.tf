terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

data "aws_availability_zones" "available" {}
provider "http" {}

resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    tomap({
     "Name" = "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster-name}" = "shared",
   })
  }"
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_cidr)
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = element(var.public_cidr,count.index)
  vpc_id            = "${aws_vpc.demo.id}"

  tags = "${
    tomap({
     "Name" = "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster-name}" = "shared",
   })
  }"
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_cidr)  
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = element(var.private_cidr,count.index)
  vpc_id            = "${aws_vpc.demo.id}"

  tags = "${
    tomap({
     "Name" = "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster-name}" = "shared",
   })
  }"
}

resource "aws_internet_gateway" "public" {
  vpc_id = "${aws_vpc.demo.id}"

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }
}
resource "aws_eip" "project_eip" {	
 }
	

resource "aws_nat_gateway" "nat_gateway" {
   allocation_id = aws_eip.project_eip.id
   subnet_id     = aws_subnet.private_subnet.*.id[1]
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_cidr)
  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count = length(var.private_cidr)
  subnet_id      = "${aws_subnet.private_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.id}"
}
