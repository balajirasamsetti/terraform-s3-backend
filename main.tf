# Create a new VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TerraformVPC"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "TerraformSubnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "TerraformIGW"
  }
}

# Create a Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "TerraformRouteTable"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformSG"
  }
}

# Create the EC2 Instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}
