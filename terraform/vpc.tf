
# Internet VPC
resource "aws_vpc" "psl-ds-main" {
  cidr_block = "172.32.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags {
    Name = "psl-ds-main"
  }
}


# Subnets
resource "aws_subnet" "psl-ds-main-public" {
  vpc_id = "${aws_vpc.psl-ds-main.id}"
  cidr_block = "172.32.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "psl-ds-main-public"
  }
}

# Internet GW
resource "aws_internet_gateway" "psl-ds-main-gw" {
  vpc_id = "${aws_vpc.psl-ds-main.id}"

  tags {
    Name = "olp-main-gw"
  }
}

# route tables
resource "aws_route_table" "psl-ds-main-public-rt" {
  vpc_id = "${aws_vpc.psl-ds-main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.psl-ds-main-gw.id}"
  }

  tags {
    Name = "olp-main-public"
  }
}

# route associations public traffic
resource "aws_route_table_association" "psl-ds-main-public-ar" {
  subnet_id = "${aws_subnet.psl-ds-main-public.id}"
  route_table_id = "${aws_route_table.psl-ds-main-public-rt.id}"
}

# nat gw
resource "aws_eip" "psl-ds-nat" {
  vpc      = true
}
resource "aws_nat_gateway" "psl-ds-nat-gw" {
  allocation_id = "${aws_eip.psl-ds-nat.id}"
  subnet_id = "${aws_subnet.psl-ds-main-public.id}"
  depends_on = ["aws_internet_gateway.psl-ds-main-gw"]
}
