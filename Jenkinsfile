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
            
        // using kubernetes cli plugin
        stage('Deploy to EKS') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'my-kubeconfig', serverUrl: 'https://07F40E9FCB6B03FE19D9C2BA8DE75202.sk1.us-east-2.eks.amazonaws.com']) {
                        sh 'kubectl apply -f spring-petclinic-deploy.yml'
                    }
                }
            }
        }        
        
  
       // using kubernetes continious deploy plugin
       // stage('Deploy to EKS') {
         //   steps {
           //     kubernetesDeploy(
             //       kubeconfigId: 'kubeconfig',
               //     configs: 'spring-petclinic-deploy.yml',
                 //   enableConfigSubstitution: true
                //)
            //}
        //}
    }
}

// aws eks --region us-east-2 update-kubeconfig --name eks
