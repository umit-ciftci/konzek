#!/bin/bash

# Pull the latest Docker image from the registry
docker pull umitciftci/my-webapp:${BUILD_NUMBER}

# Stop and remove existing containers
docker stop my-webapp-container || true && docker rm my-webapp-container || true

# Run a new container with the updated image
docker run -d -p 80:80 --name my-webapp-container umitciftci/my-webapp:${BUILD_NUMBER}

