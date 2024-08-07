pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {
        stage('Destroy VPC Link') {
            steps {
                dir('vpc_link') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Destroy LoadBalancer') {
            steps {
                dir('LoadBalancers') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Destroy LoadBalancer Controller') {
            steps {
                dir('LoadBalancer_Controller') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Destroy EKS Cluster') {
            steps {
                dir('EKS_Cluster_withNodeG') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Destroy Networking') {
            steps {
                dir('Networking') {
                    script {
                        sh 'terraform init'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }
}
