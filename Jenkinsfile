pipeline {
    agent {
        label 'jenkins-agent'
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        AWS_ACCOUNT_ID = "595496445232"
        AWS_REGION = "us-east-1"
        IMAGE_REPO_NAME = "vaibhav"
        IMAGE_NAME = "demo-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        REPOSITORY_URL = "595496445232.dkr.ecr.us-east-1.amazonaws.com/vaibhav"
        TASK_DEFINITION = "java-app"
        CONTAINER_NAME = "java-app"
        ECR_REPO_NAME = "vaibhav"
        TERRAFORM_DIR = "terraform"
    }
    stages{
        stage("clean workspace") {
            steps{
                cleanWs()
            }
        }
        
        stage('Checkout from Git') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/katoch1234/k8-e2e-jenkins.git'
            }
        }

        stage('Build application') {
            steps {
                sh "mvn clean package"
            }
        }
        stage('Test the application') {
            steps {
                sh "mvn test"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script{
                withSonarQubeEnv(credentialsId: 'sonarqube-jenkins'){
                sh "mvn sonar:sonar"
            }
            }
            }
        }
        stage('Quality Gate') {
            steps {
                script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube-jenkins'
            }
            }
        }

        stage ('Logging to ECR') {
            steps {
                script {
                    sh "whoami"
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com"
                }
            }
        }

        stage ('Docker Build') {
            steps {
                sh "printenv"
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        stage ('Docker Push') {
            steps {
                script{
                sh "docker tag ${IMAGE_NAME}:latest 595496445232.dkr.ecr.us-east-1.amazonaws.com/vaibhav:${BUILD_NUMBER}"
                sh "docker push 595496445232.dkr.ecr.us-east-1.amazonaws.com/vaibhav:${BUILD_NUMBER}"
            }
            }
        }

         stage('Terraform Init') {
            steps {
                script {
                  // initialize terraform
                     dir(TERRAFORM_DIR) {
                        sh "terraform init"
                     }

                }
}
         }
    }
}