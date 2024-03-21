pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("my-webapp:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('https://umitciftci', 'credentials-id') {
                        docker.image("my-webapp:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }
}

