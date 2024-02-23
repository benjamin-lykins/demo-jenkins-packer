pipeline {
    agent {
        label 'packer'
    }
    environment {
        AZURE_SUBSCRIPTION_ID = credentials('azure_subscription_id')
        AZURE_TENANT_ID = credentials('azure_tenant_id')
        AZURE_CLIENT_ID = credentials('azure_client_id')
        AZURE_CLIENT_SECRET = credentials('azure_client_secret')
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
                packer init ./packer/builds
                '''
            }
        }
        stage('Run Packer Validate') {
            steps {
                sh '''
                packer validate ./packer/builds
                '''
            }
        }
        stage('Run Packer Build') {
            steps {
                sh '''
                packer build \
                -var "azure_tenant_id=$AZURE_TENANT_ID" \
                -var "azure_subscription_id=$AZURE_SUBSCRIPTION_ID" \
                -var "azure_client_id=$AZURE_CLIENT_ID" \
                -var "azure_client_secret=$AZURE_CLIENT_SECRET" \
                ./packer/builds/builds_suse.pkr.hcl
                '''
            }
        }
    }
}
