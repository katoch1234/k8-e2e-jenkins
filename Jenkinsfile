pipeline {
    agent {
        label 'jenkins-agent'
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage('Checkout from Git') {
            steps {
                git branch: 'main', CredentialsId: 'github', url: ''
            }
    
        branch:'main', CredentialsId: 
        }
        }
}