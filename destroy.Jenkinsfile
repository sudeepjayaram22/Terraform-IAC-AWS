pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {
        stage('Setup Networking') {
            steps {
                dir('Networking') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Setup EKS Cluster') {
            steps {
                dir('EKS_Cluster_withNodeG') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Setup LoadBalancer Controller') {
            steps {
                dir('LoadBalancer_Controller') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Setup LoadBalancer') {
            steps {
                dir('LoadBalancers') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Setup VPC Link') {
            steps {
                dir('vpc_link') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }
}