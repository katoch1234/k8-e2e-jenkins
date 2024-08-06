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
        AWS_DEFAULT_REGION = "us-east-1"
        IMAGE_REPO_NAME = "vaibhav"
        IMAGE_TAG = "${BUILD_NUMBER}"
        REPOSITORY_URL = "595496445232.dkr.ecr.us-east-1.amazonaws.com/vaibhav"
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
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com"
                }
            }
        }

        stage ('Docker Build') {
            steps {
                sh "printenv"
                sh "docker build -t ecr-demo ."
            }
        }
        }
}