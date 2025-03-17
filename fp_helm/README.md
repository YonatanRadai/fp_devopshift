# Helm Charts for DevOpShift

This directory contains Helm charts for deploying the DevOpShift application in a Kubernetes cluster using Helm.

## Prerequisites

- Kubernetes cluster (local or cloud-based)
- kubectl CLI tool installed
- Helm CLI tool installed
- Docker images pushed to a registry
- AWS CLI configured (for AWS integrations)
- Set the AWS:
export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="us-east-1"


## Directory Structure

```
fp_helm/
├── charts/
│   └── devopshift/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           └── configmap.yaml
├── secrets/
│   └── aws-secret.yaml
└── README.md
```

## Helm Chart Components

1. **Chart.yaml**
   - Metadata about the chart (name, version, description)

2. **values.yaml**
   - Default configuration values for the chart

3. **Templates**
   - Kubernetes resource templates (Deployment, Service, ConfigMap)

4. **Secrets**
   - AWS credentials and other sensitive information

## Deployment Instructions

1. Add the Helm repository (if using a remote repository):
```bash
helm repo add devopshift-repo https://example.com/helm-charts
helm repo update
```

2. Install the Helm chart:
```bash
helm install devopshift charts/devopshift --namespace devopshift
```

3. Verify deployment:
```bash
kubectl get pods -n devopshift
kubectl get services -n devopshift
```

## Configuration

Install the chart with custom values:
```bash
helm install devopshift charts/devopshift --namespace devopshift  --set aws.accessKeyId=$AWS_ACCESS_KEY_ID   --set aws.secretAccessKey=$AWS_SECRET_ACCESS_KEY
```

### Resource Limits
```yaml
resources:
  requests:
    cpu: "250m"
    memory: "512Mi"
  limits:
    cpu: "500m"
    memory: "1Gi"
```

### Port Configuration
- Application Port: 5001
- Service Port: 80

## Monitoring

Check deployment status:
```bash
kubectl describe deployment devopshift -n devopshift
kubectl logs -l app=devopshift -n devopshift
```

## Scaling

Manual scaling:
```bash
helm upgrade devopshift charts/devopshift --namespace devopshift --set replicaCount=5
```
