# Go Application

This repository contains a Go application with automated CI/CD deployment using GitHub Actions.

## Project Structure

```
├── README.md
├── go.mod
├── go.sum
├── main.go
├── Dockerfile
├── docker-compose.yaml
└── .github/workflows/build-deploy.yml
```

## GitHub Actions Workflow

The CI/CD pipeline automatically:

1. Builds the Go application using a multistage Dockerfile
2. Pushes the Docker image to GitHub Container Registry (ghcr.io)
3. Updates the version in docker-compose.yaml
4. Deploys to the server via SSH

### Branch-based Versioning

- **Main branch:** Tagged with date-based version (e.g., `v2025.03.15`)
- **Development branch:** Tagged with short commit SHA (e.g., `a1b2c3d`)

## Setup Instructions

### Required GitHub Secrets

Add these secrets to your repository:

- `SERVER_HOST`: Your deployment server hostname or IP
- `SERVER_USERNAME`: SSH username for the deployment server
- `SSH_PRIVATE_KEY`: SSH private key for authentication

### Local Development

```bash
# Build and run locally
go run main.go

# Using Docker Compose
docker-compose up -d
```

### Manual Deployment

```bash
# Build the Docker image
docker build -t ghcr.io/username/repo:latest .

# Push to GitHub Container Registry
docker push ghcr.io/username/repo:latest

# Deploy with docker-compose
docker-compose up -d
```

## Notes

- Make sure to update the image name in docker-compose.yaml with your actual GitHub username and repository name
- The deployment path on the server needs to be updated in the GitHub Actions workflow