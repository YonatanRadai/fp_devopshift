# Terraform Infrastructure Setup

This terraform configuration sets up the AWS infrastructure required for the DevOpShift project. It provisions an EC2 instance with Docker and Docker Compose pre-installed in a custom VPC setup.

## Prerequisites

- Terraform installed locally
- AWS CLI configured
- SSH key pair generated (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

## AWS Credentials Setup

Before running Terraform, set up your AWS credentials as environment variables:

```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Infrastructure Components

- VPC (using existing VPC)
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance (t3.medium with Amazon Linux 2)

## Security Group Rules

- Inbound: SSH (22)
- Inbound: Custom Application Port (5001)
- Outbound: All traffic

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## Instance Configuration

The EC2 instance is automatically configured with:
- Docker
- Docker Compose
- Required system updates

## Notes

- The instance uses an existing VPC with ID: vpc-044604d0bfb707142
- The public subnet CIDR is: 172.31.112.0/20
- Instance type is t3.medium
- The configuration uses your local SSH public key for authentication

## Security Considerations

- Keep your AWS credentials secure and never commit them to version control
- The security group allows SSH access from any IP (0.0.0.0/0) - consider restricting this in production
- Instance has a public IP for easy access - evaluate if this is necessary for your use case