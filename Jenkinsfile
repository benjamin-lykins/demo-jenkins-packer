pipeline {
    agent {
        label 'packer'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [cleanBeforeCheckout()], userRemoteConfigs: [[url: 'https://github.com/benjamin-lykins/demo-jenkins-packer.git']])
            }
        }
        stage('Download Packer') {
            steps {
                sh '''
                sudo wget -qO - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg --yes
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt purge --auto-remove -y packer
                sudo apt update && sudo apt install -y packer
                '''
            }
        }
        stage('Run Packer Init') {
            steps {
                sh '''
                sudo packer init ./packer/builds
                '''
            }
        }
        stage('Run Packer Validate') {
            steps {
                sh '''
                sudo packer validate ./packer/builds
                '''
            }
        }
    }
}
