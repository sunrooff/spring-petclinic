pipeline {
    agent any
    tools {
        maven "3.6.3"
    }

    stages {
        stage ('SCM Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sunrooff/spring-petclinic.git'
            }
        }

        stage ('Build') {
            steps {
                sh "./mvnw package"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build("sunrooff/petclinicapp")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-key') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Deploy to AWS eks') {
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
