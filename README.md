# DevOpShift Project

A comprehensive DevOps project demonstrating CI/CD pipeline implementation across multiple platforms and cloud services.

## Report Link

link to the report that was asked in this exam: [Yonatan's report](https://docs.google.com/document/d/1k0GEgqbutgzt__0JzhWyTJ8iEL8BmuY9ZMOkfQ5pYpY/edit?addon_store&tab=t.0).

## Project Structure

```
fp_devopshift/
├── fp_docker/             # Docker configuration and application code
├── fp_terraform/          # Infrastructure as Code using Terraform
├── fp_jenkins/            # Jenkins CI/CD pipeline configuration
├── fp_azure_pipeline/     # Azure DevOps pipeline configuration
├── fp_k8s_deployment/     # Kubernetes deployment manifests
├── fp_helm/               # Helm charts for Kubernetes deployment
└── README.md
```

## Prerequisites

- Docker Desktop
- Terraform CLI
- AWS CLI
- Python 3.9+
- Jenkins or Azure DevOps account
- Kubernetes cluster access
- Helm CLI tool (for Helm deployments)

## Components

### Docker Configuration
- Python web application
- Multi-stage build
- AWS SDK integration

### Terraform Infrastructure
- AWS VPC setup
- EC2 instance provisioning
- Security group configuration

### Jenkins Pipeline
- Automated build and test
- Docker image publication
- AWS deployment integration

### Azure Pipeline
- Alternative CI/CD implementation
- Docker Hub integration
- Azure services deployment

### Kubernetes Deployment
- Production-grade deployment
- Service configurations
- Secret management

### Helm Charts
- Simplified Kubernetes deployments
- Customizable values
- Easy upgrades and rollbacks

## Security Considerations

- AWS credentials management
- Docker security best practices
- Kubernetes RBAC implementation
- Pipeline security measures

## Acknowledgments

- AWS Documentation
- Terraform Documentation
- Jenkins Community
- Azure DevOps Documentation
- Kubernetes Documentation

