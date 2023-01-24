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
                sh 'terraform plan'
            }
        }
    }
}
