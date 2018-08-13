# Define AWS as our provider
provider "aws" {
  region = "${var.aws_region}"
}


# Define VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "risktalk-vpc"
  }
}

# Define Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "risktalk-vpc-igw"
  }
}


# Define Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "public-subnet-route-tabel"
  }
}

# Assign Route Table to Public Subnets
resource "aws_route_table_association" "public-rt1" {
  subnet_id = "${aws_subnet.public-subnet1.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "public-rt2" {
  subnet_id = "${aws_subnet.public-subnet2.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "public-rt3" {
  subnet_id = "${aws_subnet.public-subnet3.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}


# Define DB Subnet
resource  "aws_db_subnet_group" "db-subnet" {
  name       = "db-subnet"
  subnet_ids = ["${aws_subnet.db-subnet1.id}", "${aws_subnet.db-subnet2.id}"]

  tags {
    Name = "risktalk-db-subnet"
  }
}