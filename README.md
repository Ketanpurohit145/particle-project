
# 👋 Hi, I'm Ketan Purohit – DevOps Specialist
🚀 Passionate about building scalable, automated, and reliable infrastructure.

🛠️ Tech Stack & Expertise
* CI/CD & Automation: Jenkins, GitLab CI/CD, Ansible
* Containers & Orchestration: Docker, Kubernetes
* Cloud & Infrastructure: AWS (EC2, S3, ECS, etc.), Terraform 
* Web & API Management: Nginx, Apache HTTP Server, Kong API Gateway
* Monitoring & Security: Grafana, Prometheus, ELK, SonarQube, OWASP Zap
* Version Control & Build Tools: Git, Maven
* Microservices & Deployment Strategies
💡 What I Do  

✅ Design and manage scalable infrastructure  
✅ Automate deployments and CI/CD pipelines       
✅ Implement DevOps best practices for high availability and performance  
✅ Monitor system health and security compliance

📫 Connect with Me 
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](your-linkedin-url)   


# Containerized Application Deployment with Terraform & ECS



## Overview

This project automates the deployment of a containerized application using Amazon ECS (Elastic Container Service). The infrastructure is provisioned using Terraform, which sets up:

* 2 Public Subnets (for NAT Gateway, Load Balancer, Bation Host)

* 2 Private Subnets (for ECS Cluster & Tasks)

* ECS Cluster running in private subnets

* ECS Tasks that host the application inside containers

* Docker Repository for storing built application images
## Prerequisites

Ensure you have the following installed:

AWS CLI (configure for appropriate authentication) - [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```bash
aws configure
```
Terraform - [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

```bash
terraform -v
```
Docker - [Install Docker](https://docs.docker.com/engine/install/ubuntu/)

```bash
docker -v
```
Git (to clone the repository) - [Install Git](https://github.com/git-guides/install-git)

```bash
git --version
```


## Run Locally

Clone the project

```bash
  git clone https://github.com/Ketanpurohit145/particle-project
```

Go to the project directory

```bash
  cd particle-project/simple-time-service
```

Docker build command 

```bash
  docker build -t ketanpurohit145/simpletimeservice:0.0.6 . --no-cache
```

Docker Push command

📌 **Note:** The image is been already pushed to the dockerhub if you want to push it in your repository please follow below commands and add repository url in terraform ecs module task defination section to clone image from your repo.


```bash
docker login -u <your-dockerhub-username> -p <your-dockerhub-password>

docker tag <your-dockerhub-username>/<your-repo-name>:latest <your-dockerhub-username>/<your-repo-name>:latest

docker push <your-dockerhub-username>/<your-repo-name>:latest
```

Docker run command to start container locally 

```bash
  docker run -d -p 5000:5000 --name simple-time -t simpletimeservice:0.0.6
```

Command to check logs  

```bash
  docker logs -f simple-time 
```

### Deploying Infrastructure using Terraform

Go to terraform configuration
```bash
cd particle-project/terraform/
```

Initialize Terraform

```bash
terraform init
```

Validate the Terraform Configuration

```bash
terraform validate
```
Plan the Deployment

```bash
terraform plan
```
Apply Terraform Configuration

```bash 
terraform apply -auto-approve
```

This will create the required VPC, subnets, ECS cluster, and deploy the containerized application.

### Verifying Deployment

* Check the ECS Cluster in AWS Console: ECS > Clusters

* Verify running ECS Tasks in the clust

Get the DNS of the Load Balancer and copy it into the browser to verify the successful deployment of the application

```bash
aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].DNSName" --output text\n
```

### Destroying Infrastructure

To clean up all resources:
```bash
terraform destroy -auto-approve
```


## Future Enhancements

* Use Terraform Remote State for better state management

* Implement CI/CD pipeline for automated deployments