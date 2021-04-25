pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_NAME = "sunrooff/petclinicapp"
    }
    
    // Global configuration should be done (pre-install maven plugin)
    tools {
        maven "3.6.3"
    }

    stages {
        stage ('Build') {
            steps {
                sh "./mvnw package"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }

        // Create Credentials for DockerHub via token
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
                        app.push("${env.BUILD_NUMBER}")
                        // app.push("latest")
                    }
                }
            }
        }

        // Create Credentials for DockerHub via token
        // docker
        stage('Deploy to eks') {
            steps {
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'spring-petclinic-deploy.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}

// aws eks --region us-east-2 update-kubeconfig --name eks
