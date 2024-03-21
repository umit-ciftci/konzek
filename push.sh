#!/bin/bash

# Docker görüntüsünü yüklemek için push.sh betiği

# Değişkenler
DOCKER_REGISTRY"https://registry.example.com"
CREDENTIALS_ID="dockerhub-credentials"
DOCKER_IMAGE_NAME="my-webapp-image"
TAG="latest"

# Docker görüntüsünün yüklenmesi
docker login -u username -p password $DOCKER_REGISTRY  # Docker registry'ye giriş yapılması
docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$TAG   # Docker görüntüsünün yüklenmesi

