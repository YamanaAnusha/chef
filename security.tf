resource "aws_vpc" "myvpc" {

  cidr_block = "10.10.0.0/16"
  tags {
    Name = "myvpc"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "10.10.0.0/24"

  tags {
    Name = "Mysubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags {
    Name = "igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
  resource "aws_route_table_association" "ass_1" {
    subnet_id = "${aws_subnet.mysubnet.id}"
    route_table_id = "${aws_route_table.rt.id}"

}

resource "aws_security_group" "allowall" {
  name        = "allowall"
  vpc_id      = "${aws_vpc.myvpc.id}"

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
