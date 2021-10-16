resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${lower(var.prefix)}-vpc"
  }
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "${lower(var.prefix)}-public-1"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${lower(var.prefix)}-igw"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${lower(var.prefix)}-rt"
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

resource "aws_security_group" "this" {
  name        = "${lower(var.prefix)}-ECSSecurityGroup"
  description = "ECS Allowed Ports"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${lower(var.prefix)}-sg"
  }
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9092
  to_port           = 9092
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}