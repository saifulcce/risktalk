# Define DB Subnets
resource "aws_subnet" "db-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.db_subnet_1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "10.0.21.0-db-subnet-us-east-1a"
  }
}

resource "aws_subnet" "db-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.db_subnet_2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "10.0.22.0-db-subnet-us-east-1b"
  }
}

resource "aws_subnet" "db-subnet3" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.db_subnet_3}"
  availability_zone = "us-east-1c"

  tags {
    Name = "10.0.23.0-db-subnet-us-east-1c"
  }
}