# Kubernetes Deployment Configuration

This directory contains Kubernetes manifests and configuration files for deploying the DevOpShift application in a Kubernetes cluster.

## Prerequisites

- Kubernetes cluster (local or cloud-based)
- kubectl CLI tool installed
- Docker images pushed to a registry
- AWS CLI configured (for AWS integrations)

## Directory Structure

```
fp_k8s_deployment/
├── manifests/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── configmap.yaml
├── secrets/
│   └── aws-secret.yaml
└── README.md
```

## Deployment Components

1. **Deployment**
   - Manages application pods
   - Handles rolling updates
   - Sets resource limits

2. **Service**
   - Exposes application ports
   - Manages load balancing
   - Provides stable network identity

3. **ConfigMap**
   - Stores configuration data
   - Environment variables
   - Application settings

4. **Secrets**
   - Stores AWS credentials
   - Sensitive information
   - Encrypted storage

## Deployment Instructions

1. Create namespace:
```bash
kubectl create namespace devopshift
```

2. Apply AWS secrets:
```bash
kubectl apply -f secrets/aws-secret.yaml -n devopshift
```

3. Deploy application:
```bash
kubectl apply -f manifests/ -n devopshift
```

4. Verify deployment:
```bash
kubectl get pods -n devopshift
kubectl get services -n devopshift
```

## Configuration

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
kubectl scale deployment devopshift --replicas=3 -n devopshift
```

## Troubleshooting

1. Check pod status:
```bash
kubectl get pods -n devopshift
kubectl describe pod <pod-name> -n devopshift
```

2. View logs:
```bash
kubectl logs <pod-name> -n devopshift
```

3. Common Issues:
   - ImagePullBackOff: Check image registry credentials
   - CrashLoopBackOff: Check application logs
   - Pending: Check resource availability

