pipeline {
    agent any

    environment {
        ACCOUNT_ID = credentials('7879377')
        API_KEY = credentials('newrelic-api-key')
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/pppawan158/newrelic-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var "account_id=$ACCOUNT_ID" -var "api_key=$API_KEY"'
            }
        }

        stage('Approval') {
            steps {
                input "Apply changes?"
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve -var "account_id=$ACCOUNT_ID" -var "api_key=$API_KEY"'
            }
        }
    }
}
