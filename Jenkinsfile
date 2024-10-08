pipeline {
    agent any
    // agent {
    //     any {
    //         image 'hashicorp/terraform:1.6.1'
    //         args '-v /root/.aws:/root/.aws'
    //     }
    // }
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        TERRAFORM_VERSION = '1.6.1' // Specify the Terraform version you need

    }
    tools {
        terraform 'Terraform'  // Use the configured tool
    }
    stages {
        stage('Setup Networking') {
            steps {
                dir('Networking') {
                    script {
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply -auto-approve'
                    }
                    script {
                        env.VPC_ID = sh(script: 'terraform output -raw vpc_id', returnStdout: true).trim()
                        env.PUBLIC_SUBNETS = sh(script: 'terraform output -json public_subnets', returnStdout: true).trim()
                        env.PRIVATE_SUBNETS = sh(script: 'terraform output -json private_subnets', returnStdout: true).trim()
                        env.SECURITY_GROUP_ID = sh(script: 'terraform output -json security_group_id', returnStdout: true).trim()
                    }
                }
            }
        }
        stage('Setup EKS Cluster') {
            steps {
                dir('EKS_Cluster_withNodeG') {
                    script {
                        // def publicSubnets = readJSON(text: PUBLIC_SUBNETS)
                        // def privateSubnets = readJSON(text: PRIVATE_SUBNETS)
                        // def allSubnets = publicSubnets + privateSubnets
                        // writeFile file: 'terraform.tfvars', text: "subnet_ids = ${groovy.json.JsonOutput.toJson(allSubnets)}"
                
                        // subnet_ids = ${groovy.json.JsonOutput.toJson(allSubnets)}

                        
                        writeFile file: 'terraform.tfvars', text: """
                        public_subnet_ids = ${env.PUBLIC_SUBNETS}
                        private_subnet_ids = ${env.PRIVATE_SUBNETS}
                        security_group_ids = ${env.SECURITY_GROUP_ID}
                        """
                        sh 'cat terraform.tfvars'
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Setup LoadBalancer Controller') {
            steps {
                dir('LoadBalancer_Controller') {
                    script {
                        writeFile file: 'terraform.tfvars', text: """
                        vpc_id = "${env.VPC_ID}"
                        """
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Setup LoadBalancer') {
            steps {
                dir('LoadBalancers') {
                    script {
                        writeFile file: 'terraform.tfvars', text: """
                        vpc_id = "${env.VPC_ID}"
                        public_subnets = ${env.PUBLIC_SUBNETS}
                        private_subnets = ${env.PRIVATE_SUBNETS}
                        """
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Setup VPC Link') {
            steps {
                dir('vpc_link') {
                    script {
                        // writeFile file: 'terraform.tfvars', text: """
                        // vpc_link_name = "my-vpc-link-nlb"
                        // """
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply -auto-approve -var=vpc_link_name=my-vpc-link-nlb'
                    }
                }
            }
        }
    }
}
