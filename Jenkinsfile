pipeline {
    agent any

    stages{
        stage("checkout") {
            steps {
                checkout scm
            }
        }
        stage("testing") {
            steps {
                script {
                    sh """
                    terraform init
                    terraform plan
                    """
                }
            }
        }
    }
}
