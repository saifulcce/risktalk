
# Define Public Subnets
resource "aws_subnet" "public-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "10.0.1.0-public-us-east-1a"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "10.0.2.0-public-us-east-1b"
  }
}

resource "aws_subnet" "public-subnet3" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_3}"
  availability_zone = "us-east-1c"

  tags {
    Name = "10.0.3.0-public-us-east-1c"
  }
}
