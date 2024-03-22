#!/bin/bash

# Değişkenler
DOCKER_REGISTRY="docker.io/umitciftci"
IMAGE_NAME="my-webapp-image"
TAG="latest"

# Docker görüntüsünü Docker Hub'a gönderme
docker push $DOCKER_REGISTRY/$IMAGE_NAME:$TAG

