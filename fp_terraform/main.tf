# main.tf
provider "aws" {
  region = "us-east-1"
}

# Use existing manually created public key from ~/.ssh/
resource "aws_key_pair" "builder_keypair" {
  key_name   = "id_rsa.pub"
  public_key = file("~/.ssh/id_rsa.pub")
}

# VPC reference (using existing VPC)
data "aws_vpc" "selected" {
  id = "vpc-044604d0bfb707142"
}

# Get existing Internet Gateway attached to VPC
data "aws_internet_gateway" "existing" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Create a new public subnet
resource "aws_subnet" "public" {
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = "172.31.112.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "builder-public-subnet"
  }
}

# Create a new route table
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.selected.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.existing.internet_gateway_id
  }

  tags = {
    Name = "builder-public-rt"
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "builder_sg" {
  name        = "builder-security-group"
  description = "Security group for builder instance"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "builder" {
  ami                    = "ami-0e1bed4f06a3b463d"  # Amazon Linux 2 AMI
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.builder_keypair.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.builder_sg.id]
  depends_on             = [aws_key_pair.builder_keypair]

  tags = {
    Name = "yonatan-builder"
  }

  # Remote execution for Docker & Docker Compose installation
provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      # Install Docker Compose
      "sudo apt-get install -y curl",
      "sudo curl -L 'https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)' '-o /usr/local/bin/docker-compose'",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
