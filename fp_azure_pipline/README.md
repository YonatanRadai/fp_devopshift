# Azure Pipeline Configuration

This directory contains Azure Pipeline configuration for the DevOpShift project, automating the CI/CD process using Azure DevOps.

## Prerequisites

- Azure DevOps account
- Docker Hub account
- Azure subscription
- Project repository connected to Azure DevOps

## Pipeline Setup

### Required Secrets and Variables

Docker Hub Credentials:
   - Create a Personal Access Token (PAT) in Docker Hub
   - Add it as a pipeline variable named `yonatantoken`
   - add  AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to variable with the credential as secret.

### Pipeline Structure

```yaml
stages:
├── Build
│   └── Docker image build and push
├── Test
│   ├── Unit tests
│   └── Integration tests
└── Push
    └── Push image to docker hub
```

## Configuration Steps

1. **Docker Hub Authentication**
   - Log in to Docker Hub
   - Navigate to Account Settings > Security
   - Create new access token
   - Copy token value

2. **Azure Pipeline Variables**
   ```
   DOCKER_USERNAME: your-dockerhub-username
   DOCKER_PAT: $(yonatantoken)
   IMAGE_NAME: your-image-name
   ```

## Usage

1. Create new pipeline in Azure DevOps
2. Select your repository
3. Configure pipeline using existing `azure-pipelines.yml`
4. Add required variables and secrets
5. Run pipeline

## Pipeline Features

- Automated Docker image building
- Unit and integration testing
- Docker image publishing
- Deployment to Azure services
- Status notifications