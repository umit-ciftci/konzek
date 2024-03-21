#!/bin/bash

# Docker görüntüsünü oluşturmak için build.sh betiği

# Değişkenler
DOCKER_IMAGE_NAME="my-webapp-image"
TAG="latest"

# Docker görüntüsünün oluşturulması
docker build -t $DOCKER_IMAGE_NAME:$TAG .

