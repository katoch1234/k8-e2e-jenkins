pipeline {
    agent {
        label 'jenkins-agent'
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
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
                withSonarQubeEnv(credentialsId: 'sonarqube-jenkins'){
                sh "mvn sonar:sonar"
            }
            }
        }
        }
}