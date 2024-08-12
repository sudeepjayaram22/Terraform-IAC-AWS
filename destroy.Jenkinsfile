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
                        try {
                            sh 'terraform init'
                            sh 'terraform destroy --auto-approve'
                        } catch (Exception e){
                            echo "Stage failed: ${e.message}"
                        }
                    }
                }
            }
        }
        stage('Destroy LoadBalancer') {
            steps {
                dir('LoadBalancers') {
                    script {
                        try {
                            sh 'terraform init'
                            sh 'terraform destroy --auto-approve'
                        } catch (Exception e){
                            echo "Stage failed: ${e.message}"
                        }
                    }
                }
            }
        }
        stage('Destroy LoadBalancer Controller') {
            steps {
                dir('LoadBalancer_Controller') {
                    script {
                        try{
                            sh 'terraform init'
                            sh 'terraform destroy --auto-approve'
                        } catch (Exception e){
                            echo "Stage failed: ${e.message}"
                        }
                    }
                }
            }
        }
        stage('Destroy EKS Cluster') {
            steps {
                dir('EKS_Cluster_withNodeG') {
                    script {
                        try{
                            sh 'terraform init'
                            sh 'terraform destroy --auto-approve'
                        } catch (Exception e){
                            echo "Stage failed: ${e.message}"
                        }
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
