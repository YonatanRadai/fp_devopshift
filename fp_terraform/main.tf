# main.tf
provider "aws" {
  region                      = "us-east-1"
  # Delete the below code for a real AWS account.
  access_key                  = "dummy" 
  secret_key                  = "dummy"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    ec2 = "http://localhost:4566"  # LocalStack endpoint
  }
}
# Generate SSH key pair
resource "tls_private_key" "builder_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "builder_keypair" {
  key_name   = "builder-key"
  public_key = tls_private_key.builder_key.public_key_openssh
}

# Save private key to a file
resource "local_file" "private_key" {
  content  = tls_private_key.builder_key.private_key_pem
  filename = "${path.module}/builder-key.pem"
  file_permission = "0400"
}

# Save public key to a file
resource "local_file" "public_key" {
  content  = tls_private_key.builder_key.public_key_openssh
  filename = "${path.module}/builder-key.pub"
  file_permission = "0644"
}

# Security Group
resource "aws_security_group" "builder_sg" {
  name        = "builder-security-group"
  description = "Security group for builder instance"

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
  ami           = "ami-0e1bed4f06a3b463d"  # Amazon Linux 2 AMI (region depended)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.builder_keypair.key_name
  security_groups = [aws_security_group.builder_sg.name]

  tags = {
    Name = "builder"
  }

  # Remote execution for Docker & Docker Compose installation
  # Can work only using real AWS account
#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum update -y",
#       "sudo amazon-linux-extras install docker -y",
#       "sudo service docker start",
#       "sudo usermod -a -G docker ec2-user",
#       "curl -L 'https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose",
#       "chmod +x /usr/local/bin/docker-compose",
#       "ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = tls_private_key.builder_key.private_key_pem
#       host        = self.public_ip
#     }
#   }
}

# Outputs
output "instance_public_ip" {
  value = aws_instance.builder.public_ip
}

output "ssh_private_key" {
  value     = tls_private_key.builder_key.private_key_pem
  sensitive = true
}

output "ssh_command" {
  value = "ssh -i builder-key.pem ec2-user@${aws_instance.builder.public_ip}"
}