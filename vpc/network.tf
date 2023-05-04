resource "aws_vpc" "core" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-core"
  }
}

resource "aws_subnet" "mantle" {
  vpc_id     = aws_vpc.core.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-mantle"
  }
}

resource "aws_internet_gateway" "crust" {
  vpc_id = aws_vpc.core.id

  tags = {
    Name = "internet_gateway-crust"
  }
}

resource "aws_route_table" "mineral" {
  vpc_id = aws_vpc.core.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crust.id
  }

  tags = {
    Name = "route_table-mineral"
  }
}

resource "aws_route_table_association" "rock" {
  subnet_id      = aws_subnet.mantle.id
  route_table_id = aws_route_table.mineral.id
}

resource "aws_security_group" "tectonic" {
  name   = "tectonic"
  vpc_id = aws_vpc.core.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}