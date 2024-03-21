pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDENTIALS = credentials('umitciftci-dockerhub')
    }

    stages {
        stage('Docker Login') {
            steps {
                echo 'Logon in to Docker Hub'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                }
                echo 'Login Successful'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker Image'
                sh 'docker build -t umitciftci/my-webapp-image:$BUILD_NUMBER .'
                echo 'Docker Image built'
            }
        }

        stage('Docker Push') {
            steps {
                echo 'Pushing Image to Docker Hub'
                sh 'docker push umitciftci/my-webapp-image:$BUILD_NUMBER'
                echo 'Image pushed to Docker Hub'
            }
        }
    }
}

