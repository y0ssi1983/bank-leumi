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
                    TEST=sh (script: "./test.sh", returnStdout: true).trim()
                    echo"${TEST}"
                }
            }
        }
    }
    post {
        success {
            sh 'terraform destroy -auto-approve'
            cleanWs()
            mail (to: 'mz.yosi.dev@gmail.com',
                subject: "Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) success.",
                body: "Please visit ${env.BUILD_URL} for further information.",
            );
        }
        failure {
            echo "failed"
            mail (to: 'mz.yosi.dev@gmail.com',
                subject: "Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) failed.",
                body: "Please visit ${env.BUILD_URL} for further information.",
            );
        }
    }
}

