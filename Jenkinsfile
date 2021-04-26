pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_NAME = "sunrooff/petclinicapp"
    }
    
    // Global Jenkins Configuration should be done (pre-install maven plugin)
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

        // Before to create Credentials in Jenkins for DockerHub
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
 //       stage('Deploy to EKS') {
   //         steps {
     //           script {
       //             withKubeConfig([credentialsId: 'my-kubeconfig', serverUrl: 'https://07F40E9FCB6B03FE19D9C2BA8DE75202.sk1.us-east-2.eks.amazonaws.com']) {
         //               sh 'kubectl apply -f spring-petclinic-deploy.yml'
           //         }
             //   }
          //  }
        //}        
        
  
        // using Kubernetes Continious Deploy plugin ( works only after downgrading its version to 1.0.0 )
        // Kubernetes's config file is used to set up credentianls in Jenkins
        stage('Deploy to EKS') {
            steps {
            //  input 'Deploy to Production?'
                kubernetesDeploy(
                    kubeconfigId: 'my-kubeconfig',
                    configs: 'spring-petclinic-deploy.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
