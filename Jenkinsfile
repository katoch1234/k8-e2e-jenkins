pipeline {
    agent {
        label 'jenkins-agent'
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage("clean workspce") {
            steps{
                cleanWs()
            }
        }
        
        stage('Checkout from Git') {
            steps {
                git branch: 'main', CredentialsId: 'github', url: 'https://github.com/katoch1234/k8-e2e-jenkins.git'
            }
        }
        }
}