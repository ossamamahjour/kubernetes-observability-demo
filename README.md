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

# Move the Kind binary to a directory in my local PATH
mv kind-linux-amd64 /usr/local/bin/kind  

# Create Kind cluster
kind create cluster --name veriff-o11y

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make the kubectl binary executable and move it to a directory in my PATH
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl  

```

# 📌 Observability Stack: PGLTJ vs. LGTM

## 📖 Overview

Observability is crucial for monitoring and troubleshooting modern distributed systems. This document compares the **PGLTJ** (Prometheus, Grafana, Loki, Tempo, Jaeger) stack with **LGTM** (Loki, Grafana, Tempo, Mimir) and explains why **PGLTJ provides a more unified observability solution** by treating metrics, logs, and traces as interrelated, not independent.

---

## 🏆 Why PGLTJ?

The best observability system should **correlate telemetry types** (metrics, logs, and traces) rather than treating them separately.

For example:

- A log entry in **Loki** could reference a **traceId** in **Jaeger/Tempo**.
- A **trace event** could impact **Prometheus metrics**.
- Unified observability simplifies troubleshooting and improves system insights.

PGLTJ **ensures seamless correlation between logs, traces, and metrics**, making it superior to stacks like LGTM.

---

## 🔹 Stack Comparison

| Feature                 | **PGLTJ (Prometheus, Grafana, Loki, Tempo, Jaeger)** | **LGTM (Loki, Grafana, Tempo, Mimir)**  |
| ----------------------- | ---------------------------------------------------- | --------------------------------------- |
| **Metrics Storage**     | ✅ Prometheus                                         | ✅ Mimir (Scales better than Prometheus) |
| **Logs Storage**        | ✅ Loki                                               | ✅ Loki                                  |
| **Traces Storage**      | ✅ Tempo / Jaeger                                     | ✅ Tempo (No Jaeger)                     |
| **Visualization**       | ✅ Grafana                                            | ✅ Grafana                               |
| **Scalability**         | ⭐⭐⭐ Medium (Prometheus has limits)                   | ⭐⭐⭐⭐ High (Mimir scales better)         |
| **Ease of Setup**       | ⭐⭐ Medium                                            | ⭐⭐⭐ Easier (Fewer components)           |
| **Tracing Support**     | ✅ Tempo + Jaeger                                     | ✅ Tempo (Simpler, no Jaeger)            |
| **Resource Efficiency** | ⭐⭐ Medium (Jaeger adds complexity)                   | ⭐⭐⭐ More efficient (No Jaeger overhead) |

---

## 🔍 Key Differences

### ✅ **PGLTJ Benefits** (Why It’s Better?)

1. **Correlates Metrics, Logs, and Traces**

   - **Prometheus (metrics), Loki (logs), and Tempo/Jaeger (traces)** are fully integrated.
   - Example: Click on a **log entry** → View its **related trace** → Check affected **metrics**.

2. **Deep Trace & Log Context**

   - **Jaeger provides advanced tracing** (better than Tempo alone in LGTM).
   - **Loki logs include traceId/spanId**, enabling **quick navigation**.

3. **Unified Querying & Visualization**

   - **Grafana integrates all telemetry types in a single dashboard**.
   - No need to switch tools for logs, traces, and metrics.

4. **More Flexible Tracing**

   - **PGLTJ supports both Tempo & Jaeger**, unlike LGTM (Tempo only).
   - **Jaeger offers deeper trace analysis** for complex debugging.

---

## 🚀 When to Choose PGLTJ vs. LGTM?

### **Use PGLTJ if:**

✔ You need **full correlation** between metrics, logs, and traces.
✔ You require **advanced distributed tracing (Jaeger support)**.
✔ You want a **deep observability stack** for debugging and performance analysis.
✔ Your workload is **small-to-medium** scale and you don't need extreme metric scalability.

### **Use LGTM if:**

✔ You need **better scalability** (Mimir scales better than Prometheus).
✔ You want a **simpler setup** with fewer components.
✔ You **don’t need advanced Jaeger tracing**, just basic distributed traces with Tempo.

---

## 📌 Conclusion

**PGLTJ is the better choice** if you want a **truly unified observability stack** that treats metrics, logs, and traces as interconnected data sources. It provides **deeper tracing (Jaeger)**, **better log-trace correlation**, and **full telemetry integration in Grafana**.

If your main concern is **scalability and simplicity**, **LGTM** with Mimir is a good alternative, but it lacks **Jaeger’s deep tracing capabilities**.
---

