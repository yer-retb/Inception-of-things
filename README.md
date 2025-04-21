# Inception of Things (IoT)

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Vagrant](https://img.shields.io/badge/vagrant-%231563FF.svg?style=for-the-badge&logo=vagrant&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![ArgoCD](https://img.shields.io/badge/ArgoCD-009485?style=for-the-badge&logo=argo&logoColor=white)

## Project Overview

This project focuses on implementing and understanding Kubernetes infrastructure using K3s and K3d. It consists of three main parts and a bonus section, each designed to build upon the previous knowledge and expand understanding of container orchestration technologies.

## Table of Contents

- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Roadmap](#roadmap)
- [Part 1: K3s and Vagrant](#part-1-k3s-and-vagrant)
- [Part 2: K3s and Three Applications](#part-2-k3s-and-three-applications)
- [Part 3: K3d and Argo CD](#part-3-k3d-and-argo-cd)
- [Bonus: GitLab Integration](#bonus-gitlab-integration)
- [Installation and Usage](#installation-and-usage)
- [Troubleshooting](#troubleshooting)
- [Resources](#resources)

## Project Structure

```
.
├── p1
│   ├── Vagrantfile        # Vagrant configuration for Part 1
│   ├── scripts            # Server and worker node setup scripts
│   └── confs              # K3s configuration files
├── p2
│   ├── Vagrantfile        # Vagrant configuration for Part 2
│   ├── scripts            # Installation scripts
│   └── confs              # App deployments and ingress configurations
├── p3
│   ├── scripts            # K3d and Argo CD setup scripts
│   └── confs              # Application deployment manifests
└── bonus
    ├── Vagrantfile        # Vagrant configuration for GitLab setup
    ├── scripts            # GitLab installation scripts
    └── confs              # GitLab runner and Kubernetes integration configs
```

## Requirements

- **VirtualBox** (or any other Vagrant provider)
- **Vagrant**
- Basic understanding of:
  - Kubernetes concepts
  - Docker
  - YAML configuration
  - Networking fundamentals

## Roadmap

(bonus/IOT.png)

## Part 1: K3s and Vagrant

This part involves setting up two virtual machines using Vagrant and installing K3s on them - one as a controller and the other as a worker node.

### Configuration Details

- **Server Node**: 
  - Hostname: `yer-retbS`
  - IP Address: 192.168.56.110
  - Role: K3s Server (Controller)

- **Worker Node**: 
  - Hostname: `yer-retbSW`
  - IP Address: 192.168.56.111
  - Role: K3s Agent

### Implementation

1. The Vagrantfile configures both VMs with minimal resources (1 CPU, 512 MB RAM)
2. Shell scripts automate the installation of K3s in the appropriate modes
3. SSH access is configured without password authentication
4. Kubernetes CLI (kubectl) is installed and configured to interact with the cluster

## Part 2: K3s and Three Applications

In this part, a single VM runs three web applications that are accessible through different hostnames pointing to the same IP address.

### Configuration Details

- **Server**: 
  - Hostname: `yer-retbS`
  - IP Address: 192.168.56.110
  - Applications:
    - App1: Accessible via `app1.com`
    - App2: Accessible via `app2.com` (with 3 replicas)
    - App3: Default application (when no matching host is provided)

### Implementation

1. The VM is configured with K3s in server mode
2. Kubernetes manifests define three deployments and services
3. An Ingress controller routes traffic based on the Host header
4. Replicas are managed through the deployment configurations

## Part 3: K3d and Argo CD

This part focuses on continuous deployment using K3d (a lightweight Kubernetes distribution that runs inside Docker containers) and Argo CD.

### Configuration Details

- K3d cluster running locally
- Two namespaces:
  - `argocd`: Contains the Argo CD application
  - `dev`: Contains the deployed application (two versions available)

### Implementation

1. Installation script sets up Docker, K3d, and necessary tools
2. Argo CD is deployed in its dedicated namespace
3. An application is configured in Argo CD to monitor a GitHub repository
4. The application can be switched between versions v1 and v2 by updating the GitHub repository

## Bonus: GitLab Integration

The bonus part extends the CI/CD pipeline by integrating a self-hosted GitLab instance.

### Configuration Details

- GitLab running in a dedicated namespace (`gitlab`)
- Integration with the Kubernetes cluster
- CI/CD pipeline for the application deployment

### Implementation

1. GitLab is installed and configured using Helm
2. GitLab runners are set up to interact with the Kubernetes cluster
3. CI/CD pipeline is configured to deploy the application

## Installation and Usage

### Part 1

```bash
# Navigate to the p1 directory
cd p1

# Start the VMs
vagrant up

# SSH into the server node
vagrant ssh yer-retbS

# Check the cluster status
kubectl get nodes
```

### Part 2

```bash
# Navigate to the p2 directory
cd p2

# Start the VM
vagrant up

# SSH into the server
vagrant ssh yer-retbS

# Check the deployments and ingress
kubectl get pods,svc,ingress
```

### Part 3

```bash
# Navigate to the p3 directory
cd p3

# Run the setup script
./scripts/setup.sh

# Check Argo CD installation
kubectl get pods -n argocd

# Access Argo CD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Check the application deployment
kubectl get pods -n dev
```

### Bonus Part

```bash
# Navigate to the bonus directory
cd bonus

# Run the setup script
./scripts/setup.sh

# Check GitLab installation
kubectl get pods -n gitlab
```

## Troubleshooting

### Common Issues:

1. **VM Networking Problems**:
   - Ensure VirtualBox network interfaces are configured correctly
   - Check that IP addresses don't conflict with existing network configurations

2. **K3s Installation Failures**:
   - Verify system requirements are met
   - Check logs with `sudo journalctl -u k3s`

3. **Application Deployment Issues**:
   - Verify YAML syntax in manifests
   - Check pod status with `kubectl describe pod <pod-name>`
   - Examine container logs with `kubectl logs <pod-name>`

4. **Ingress Problems**:
   - Ensure /etc/hosts is configured for local domain resolution
   - Verify Ingress controller is running properly

5. **Argo CD Synchronization Issues**:
   - Check repository accessibility
   - Verify YAML syntax in manifests
   - Examine Argo CD application status

## Resources

- [K3s Documentation](https://rancher.com/docs/k3s/latest/en/)
- [K3d Documentation](https://k3d.io/v5.4.6/)
- [Vagrant Documentation](https://www.vagrantup.com/docs)
- [Argo CD Documentation](https://argo-cd.readthedocs.io/en/stable/)
- [GitLab Documentation](https://docs.gitlab.com/ee/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)