# Jenkins CI/CD Configuration

This directory contains Jenkins pipeline configuration for the DevOpShift project, automating the build, test, and deployment processes.

## Pipeline Overview

The Jenkins pipeline includes the following stages:
- Checkout source code
- Build Docker image
- Run tests
- Cleanup Docker Images & Containers

## Prerequisites

- Jenkins server installed and configured
- Docker plugin installed in Jenkins agent

## Jenkins Configuration


### Credentials Setup

Configure the following credentials in Jenkins:
'yonatantoken' to the PAT of docker hub.


## Usage

1. Create a new Pipeline job in Jenkins
2. Configure GitHub webhook
3. Point to the Jenkinsfile in the repository
4. Set required credentials
5. Run the pipeline

### Note
In order to run this pipeline on main make sure you change branch from main to dev in the cloning step.