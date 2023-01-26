pipeline {
    agent any

    stages{
        stage("checkout") {
            steps {
                checkout scm
            }
        }
        stage('build') {
            steps {
                script {
                    sh """
                    terraform init
                    terraform plan
                    terraform apply -auto-approve
                    """
                }
            }
        }
        stage("testing") {
            steps {
                script {
                    sh """
                    sleep 5
                    ./test.sh
                    """
                }
            }
        }
    }
}
