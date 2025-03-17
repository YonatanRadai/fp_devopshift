# outputs.tf
output "instance_public_ip" {
  value = aws_instance.builder.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa.pub ubuntu@${aws_instance.builder.public_ip}"  
}

output "vpc_cidr_block" {
  value       = data.aws_vpc.selected.cidr_block
  description = "The CIDR block of the VPC"
}