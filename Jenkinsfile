pipeline {
    agent any
    
    environment {
        PACKER_BINARY = 'packer'
        PACKER_TEMPLATE = 'path/to/your/packer/template.json'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Packer Image') {
            steps {
                script {
                    // Validate the Packer template
                    sh "${env.PACKER_BINARY} validate ${env.PACKER_TEMPLATE}"
                    
                    // If validation passes, build the image
                    if (env.BUILD_STATUS == 0) {
                        sh "${env.PACKER_BINARY} build ${env.PACKER_TEMPLATE}"
                    } else {
                        error "Packer template validation failed!"
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Cleanup any artifacts or temporary files if necessary
        }
    }
}