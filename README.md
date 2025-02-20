# Veriff Observability (O11Y) Engineer Test Task

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.27+-blue?logo=kubernetes)
![Kind](https://img.shields.io/badge/Kind-v0.20+-blue?logo=kubernetes)
![Prometheus](https://img.shields.io/badge/Prometheus-2.45+-orange?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-10.1+-orange?logo=grafana)

A solution demonstrating Kubernetes cluster setup with **Kind**, observability stack deployment, application monitoring, and alerting for the Veriff O11Y Engineer Test Task.

---

## Table of Contents
- [Objective](#objective)
- [Solution Overview](#solution-overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Deliverables](#deliverables)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Objective
This repository fulfills the requirements of the Veriff O11Y Engineer Test Task, including:
1. ✅ Kubernetes cluster creation with **Kind** and observability support.
2. ✅ Deployment of a telemetry stack (logs, metrics, traces).
3. ✅ Deployment of a sample application with observable telemetry.
4. ✅ Monitoring configuration with alerts.
5. ✅ Comprehensive documentation for reproducibility.

---

## Solution Overview
### Architecture Diagram
![Architecture Diagram](images/architecture.png) *(Replace with your diagram)*

**Chosen Tools**:
- **Kubernetes**: Kind (local cluster in Docker)
- **Observability Stack**: Prometheus (metrics), Loki (logs), Grafana (visualization), and OpenTelemetry (traces).
- **Sample Application**: Nginx web server with custom instrumentation.

---

## Prerequisites
- [ ] Docker Desktop (with Kind support)
- [ ] `kind`, `kubectl`, and `helm` CLI tools
- [ ] 4+ GB RAM allocated to Docker

---

## Setup Instructions
### 1. Cluster Setup with Kind
```bash
# Update package index
sudo apt update 

# Install Docker
sudo apt install docker.io -y 

# Download Kind
wget https://github.com/kubernetes-sigs/kind/releases/download/v0.27.0/kind-linux-amd64

# Make the Kind binary executable
chmod +x kind-linux-amd64                                                                                      

# Move the Kind binary to a directory in your PATH
mv kind-linux-amd64 /usr/local/bin/kind  

# If you have an existing Kind cluster with the default name, delete it
kind delete cluster --name kind

# Create a new Kind cluster with the desired name
kind create cluster --name veriff-o11y

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make the kubectl binary executable and move it to a directory in your PATH
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl  

# Verify cluster
kubectl cluster-info --context kind-veriff-o11y

# Deploy Metrics Server (required for resource monitoring)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```