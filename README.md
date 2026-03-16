# Terraform 3-Tier Application with Docker & Full Observability

[![Terraform](https://img.shields.io/badge/Terraform-1.6.6-7B42BC.svg)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%2022.04-orange.svg)](https://ubuntu.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A **production-ready 3-tier web application (Task Manager)** deployed using **Terraform Infrastructure as Code** and **Docker containers**.

This project includes a **complete observability stack** with:

- Prometheus (Metrics)
- Grafana (Dashboards)
- Loki (Centralized Logging)
- Promtail (Log Shipping)

The entire infrastructure can be deployed with **a single Terraform command**.

---

# Features

- React.js Frontend
- Express.js Backend API
- PostgreSQL Database
- Fully containerized with Docker
- Infrastructure as Code using modular Terraform
- Built-in Prometheus metrics in backend
- Complete observability stack
- Auto-provisioned Grafana dashboards
- Remote Terraform state using MinIO (S3 compatible)
- One-command deployment

---

# Architecture

```mermaid
graph TD

Browser --> Frontend
Frontend --> Backend
Backend --> Postgres

subgraph Application
Frontend[React Frontend Container]
Backend[Express Backend Container]
Postgres[PostgreSQL Database Container]
end

subgraph Observability
Prometheus[Prometheus]
Grafana[Grafana]
Loki[Loki]
Promtail[Promtail]
end

Backend --> Prometheus
Postgres --> Prometheus
Promtail --> Loki
Prometheus --> Grafana
Loki --> Grafana



