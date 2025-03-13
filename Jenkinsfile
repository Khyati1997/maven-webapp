pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        GITHUB_CREDENTIALS = 'github-credentials-maven-webapp'
        IMAGE_NAME = 'khyati1997/maven-webapp'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/Khyati1997/maven-webapp.git',
                            credentialsId: GITHUB_CREDENTIALS
                        ]]
                    ])
                }
            }
        }

        stage('Build Maven Project') {
            steps {
                bat 'mvn clean package'  // Use 'bat' instead of 'sh'
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        bat 'echo %PASSWORD% | docker login -u %USERNAME% --password-stdin'  // Use Windows batch syntax
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'  // Use 'bat' instead of 'sh'
            }
        }

        stage('Docker Push') {
            steps {
                bat 'docker push %IMAGE_NAME%'  // Use 'bat' instead of 'sh'
            }
        }
    }
}
