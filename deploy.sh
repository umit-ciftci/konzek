#!/bin/bash

# Değişkenler
DOCKER_REGISTRY="docker.io/umitciftci"
IMAGE_NAME="my-webapp-image"
CONTAINER_NAME="my-webapp-container"

# Docker konteynerini durdurma ve kaldırma
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Yeni bir konteyner başlatma
docker run -d -p 8080:80 --name $CONTAINER_NAME $DOCKER_REGISTRY/$IMAGE_NAME:latest


