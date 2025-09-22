# Aura Infrastructure

This repository contains the infrastructure as code for the "Aura" project. It uses Terraform to provision the necessary cloud infrastructure on AWS and ArgoCD to deploy the application's microservices.

## Features

  * **Infrastructure as Code**: The entire infrastructure is defined as code using Terraform, which makes it easy to create, modify, and destroy resources in a repeatable and predictable way.
  * **GitOps**: The application deployments are managed using a GitOps workflow with ArgoCD. The Git repository is the single source of truth for all deployments.
  * **App of Apps Pattern**: The application is deployed using the "app of apps" pattern, where a single root application manages all the other microservices.
  * **Automated CI/CD**: The repository includes GitHub Actions workflows for one-click deployment and destruction of the entire infrastructure.

## Architecture

The infrastructure consists of a single EC2 instance that runs a Kubernetes cluster. The cluster is bootstrapped using `kubeadm`, and it runs the following services:

  * **ArgoCD**: For continuous delivery of the application's microservices.
  * **Prometheus and Grafana**: For monitoring and observability.
  * **NGINX Ingress Controller**: For routing external traffic to the application's services.
  * **Aura Microservices**: The backend, frontend, Ollama, Open-WebUI, and aura-k8s-chat microservices are deployed as ArgoCD applications.

## Getting Started

To deploy the infrastructure, you will need to have an AWS account and have the AWS CLI configured with your credentials.

1.  Clone the repository:
    ```bash
    git clone https://github.com/Richard-m-j/aura-infra.git
    ```
2.  Navigate to the `terraform` directory:
    ```bash
    cd aura-infra/terraform
    ```
3.  Create a `terraform.tfvars` file with the following variables:
    ```terraform
    argocd_password       = "your-argocd-password"
    grafana_password      = "your-grafana-password"
    aws_access_key_id     = "your-aws-access-key-id"
    aws_secret_access_key = "your-aws-secret-access-key"
    ```
4.  Initialize Terraform:
    ```bash
    terraform init
    ```
5.  Apply the Terraform configuration:
    ```bash
    terraform apply
    ```

This will provision the EC2 instance and bootstrap the Kubernetes cluster with all the necessary services.

## CI/CD Pipeline

The repository includes GitHub Actions workflows for one-click deployment and destruction of the entire infrastructure:

  * **`terraform-ec2.yml`**: This workflow deploys the infrastructure.
  * **`terraform-ec2-destroy.yml`**: This workflow destroys the infrastructure.

You can trigger these workflows from the "Actions" tab in the GitHub repository.

## Contributing

Contributions are welcome\! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License.