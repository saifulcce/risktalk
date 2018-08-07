# Define Private Subnets
resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "10.0.11.0-private-us-east-1a"
  }
}


resource "aws_subnet" "private-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "10.0.12.0-private-us-east-1b"
  }
}


resource "aws_subnet" "private-subnet3" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_3}"
  availability_zone = "us-east-1c"

  tags {
    Name = "10.0.13.0-private-us-east-1c"
  }
}
