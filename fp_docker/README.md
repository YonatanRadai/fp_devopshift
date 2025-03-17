# Docker Configuration for DevOpShift

This directory contains Docker configuration for the DevOpShift project, setting up a Python web application with AWS integration.

## Prerequisites

- Docker installed
- AWS credentials configured
- Python 3.9 or later

## Project Structure

```
fp_docker/
├── Dockerfile
├── requirements.txt
├── app.py
└── README.md
```

## Building the Docker Image

Build the image using:

```bash
docker build \
  --build-arg AWS_ACCESS_KEY_ID=your_access_key \
  --build-arg AWS_SECRET_ACCESS_KEY=your_secret_key \
  -t devopshift .
```

## Running the Container

Run the container using:

```bash
docker run -d \
  -p 5001:5001 \
  --name devopshift \
  devopshift
```

## Environment Variables

The following environment variables are required:

- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key

## Security Notes

- Never commit AWS credentials to version control
- Use `.dockerignore` to exclude sensitive files
- Consider using AWS IAM roles for production deployments
- Keep Python dependencies updated for security

## Maintenance

- Update `requirements.txt` when adding new dependencies
- Regularly update the base Python image
- Monitor container logs: `docker logs devopshift`

## Troubleshooting

If you encounter issues:

1. Check container logs: `docker logs devopshift`
2. Verify AWS credentials are set correctly
3. Ensure port 5001 is available
4. Check Python dependencies in requirements.txt

## Development

To build for development with hot-reload:

```bash
docker run -d \
  -p 5001:5001 \
  -v $(pwd):/app \
  --name devopshift-dev \
  devopshift
```