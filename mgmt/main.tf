# Define AWS as our provider
provider "aws" {
  region     = "us-east-1"
}

# Collecting "risktalk-vpc" ID
data "aws_vpc" "risktalk-vpc" {
  filter {
    name = "tag:Name"
    values = ["risktalk-vpc"]
  }
}

# Collecting "public-us-east-1c" ID
data "aws_subnet" "public-us-east-1c" {
  filter {
    name = "tag:Name"
    values = ["10.0.3.0-public-us-east-1c"]
  }
}


# Load startup script
data "template_file" "user_data" {
  template = "${file("user-data.sh")}"
}


# Defining Security Group - Allowing All Ports
resource "aws_security_group" "allow-all" {
  name = "mgmt-server-sg"
  vpc_id = "${data.aws_vpc.risktalk-vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}


# Configure Stage Instance with proper subnet & vpc
resource "aws_instance" "mgmt-server" {
  ami                    = "ami-0ac019f4fcb7cb7e6"
  instance_type          = "t2.micro"
  subnet_id = "${data.aws_subnet.public-us-east-1c.id}"
  vpc_security_group_ids = ["${aws_security_group.allow-all.id}"]
  key_name               = "rtm"
  user_data = "${data.template_file.user_data.rendered}"

  tags {
    Name = "mgmt-server"
  }
}


# Alocating Elastic IP
resource "aws_eip" "mgmt-server-elastic-ip" {
  vpc = true
}


# Associating Elastic IP with stage-instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.mgmt-server.id}"
  allocation_id = "${aws_eip.mgmt-server-elastic-ip.id}"
}


