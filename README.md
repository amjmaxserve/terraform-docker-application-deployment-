# Terraform 3-Tier Application with Docker & Full Observability

[![Terraform](https://img.shields.io/badge/Terraform-1.6.6-7B42BC.svg)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%2022.04-orange.svg)](https://ubuntu.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A complete **production-ready 3-tier web application** (Task Manager) deployed using **Terraform** as Infrastructure as Code on **Docker**. Includes a full observability stack with **Prometheus**, **Grafana**, **Loki**, and **Promtail**.

## ✨ Features

- React.js Frontend + Express.js Backend + PostgreSQL Database
- Fully containerized with Docker
- Infrastructure as Code using modular Terraform
- Built-in Prometheus metrics in the backend
- Complete observability (Metrics + Logs + Dashboards)
- Auto-provisioned Grafana dashboards
- Remote Terraform state using MinIO (S3 compatible)
- One-command deployment

## 🏗️ Architecture

```mermaid
graph TD
    Browser[Browser] --> Frontend[React Frontend<br>Docker Container]
    Frontend --> Backend[Express Backend<br>Docker Container]
    Backend --> Postgres[PostgreSQL<br>Docker Container]

    subgraph Monitoring
        Prometheus[Prometheus] --> Grafana[Grafana]
        Loki[Loki] --> Grafana
        Promtail[Promtail] --> Loki
    end

    Backend --> Prometheus
    Postgres --> Prometheus







## 📁 Project Structure

terraform-3tier/
├── app/
│   ├── backend/
│   │   ├── Dockerfile
│   │   ├── package.json
│   │   └── server.js
│   └── frontend/
│       ├── Dockerfile
│       ├── package.json
│       ├── public/
│       │   └── index.html
│       └── src/
│           ├── App.js
│           └── index.js
├── monitoring/
│   ├── prometheus.yml
│   ├── loki-config.yml
│   ├── promtail-config.yml
│   ├── grafana-data/
│   └── loki-data/
└── terraform/
    ├── provider.tf
    ├── variables.tf
    ├── main.tf
    ├── backend.tf
    ├── outputs.tf
    ├── grafana_datasource.tf
    ├── grafana_dashboards.tf
    ├── grafana_wait.tf
    └── modules/
        ├── network/main.tf
        ├── postgres/main.tf
        ├── backend/main.tf
        ├── frontend/main.tf
        └── observability/main.tf


## 🚀 Quick Start

### 1. Prerequisites

Ubuntu 22.04 Server (Recommended)
Minimum 4GB RAM, 2 CPU cores
Docker installed
Terraform 1.6.6+

### 2. Install Docker & Terraform

# Install Docker
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER   # Log out and log back in

### Install Terraform

sudo apt install wget unzip -y
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -version


### 3. Clone & Deploy

git clone https://github.com/amjmaxserve/terraform-docker-application-deployment-.git
cd terraform-docker-application-deployment-/terraform-3tier/terraform

#### Initialize Terraform
terraform init

##### Review the plan
terraform plan

#### Deploy the entire stack
terraform apply -auto-approve



### 4. Access the Application

Service,URL,Credentials
Task Manager,http://YOUR_IP:3000,-
Grafana,http://YOUR_IP:3001,admin / admin
Prometheus,http://YOUR_IP:9090,-
Backend API,http://YOUR_IP:5000/tasks,-


### 🛠️ Terraform Commands

terraform init          # Initialize
terraform validate      # Validate configuration
terraform plan          # Dry run
terraform apply         # Deploy
terraform destroy       # Destroy all resources


### 📊 Monitoring & Observability

Prometheus scrapes metrics from backend, node_exporter, cAdvisor, and postgres_exporter
Grafana comes with pre-configured dashboards:
Node Exporter Overview
Docker Containers
PostgreSQL Metrics

Loki + Promtail for centralized logging


### 🔧 Optional: MinIO Remote State (S3 Compatible)

docker run -d -p 9000:9000 -p 9001:9001 \
  -e MINIO_ROOT_USER=admin \
  -e MINIO_ROOT_PASSWORD=password \
  --name minio \
  minio/minio server /data --console-address ":9001"


### 📋 Application Endpoints

POST/tasks → Create new task
GET/tasks → Get all tasks
DELETE/tasks/:id → Delete task


### 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Fork the project
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request


### 📄 License

Distributed under the MIT License. See LICENSE for more information.

Built with ❤️ for DevOps enthusiasts
Repository: https://github.com/amjmaxserve/terraform-docker-application-deployment-
Any feedback or suggestions? Feel free to open an issue!








