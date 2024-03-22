pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "docker.io/umitciftci"
        IMAGE_NAME = "my-webapp-image"
        GIT_REPO = "https://github.com/umit-ciftci/konzek.git"
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: "${GIT_REPO}"]]])
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    docker.build("${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-cred') {
                        docker.image("${DOCKER_REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! Docker image has been pushed to Docker Hub.'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

