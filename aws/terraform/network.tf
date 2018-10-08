# VPC

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  enable_dns_hostnames  = "true"
  assign_generated_ipv6_cidr_block = false

  tags {
    Name = "main"
  }
}

data "aws_availability_zones" "available" {}
# Subnets

resource "aws_subnet" "primary" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block,8,1)}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "main"
  }
}
resource "aws_subnet" "secondary" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block,8,2)}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "main"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}

# Route Table

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "main"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.primary.id}"
  route_table_id = "${aws_route_table.main.id}"
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  # WinRM access from anywhere
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # RDP access from anywhere
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all"
  }
}

