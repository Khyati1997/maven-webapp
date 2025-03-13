pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        IMAGE_NAME = 'khyati1997/maven-webapp'  // Replace with your actual Docker Hub username
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/your-repo.git'  // Replace with your GitHub repo
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $IMAGE_NAME'
            }
        }
    }
}
