#!/bin/bash

# Konteyneri başlatmak ve durdurmak için deploy.sh betiği

# Değişkenler
CONTAINER_NAME="my-webapp-container"
IMAGE_NAME="my-webapp-image"
TAG="latest"
PORT_MAPPING="8081:80"

# Eski konteyneri durdurma
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Yeni konteyneri başlatma
docker run -d --name $CONTAINER_NAME -p $PORT_MAPPING $IMAGE_NAME:$TAG

