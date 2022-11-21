---
title: "4. Container orchestration with Kubernetes"
subtitle: "Infrastructure Automation<br/>HOGENT applied computer science"
author: Bert Van Vreckem & Thomas Aelbrecht
date: 2022-2023
---

# Container orchestration: Kubernetes

## Learning goals

- TODO

## Requirements for containers in production

- Scalability & availability
- Dependencies between containers
    - Load balancer
    - Database/persistent storage
- Multi-host container
- Rolling updates/rollbacks
- ...

**It's complicated!**

## Container orchestration

= tool that allows container management at scale

- Apache Mesos
- Docker Swarm
- Rancher
- Nomad
- Kubernetes - has become "market leader"

## Kubernetes by Google

> Kubernetes (k8s) is an open source project that enables software teams of all sizes, from a small startup to a Fortune 100 company, to automate deploying, scaling, and managing applications on a group or cluster of server machines
>
> These applications can include everything from internal-facing web applications like a content management system, to marquee web properties like Gmail, to big data processing.
>
> -- Jo Beda (Google)

## Kubernetes architecture

![](assets/k8s-architecture.png)

## "Management node"

- Sysadmin interacts with Master Node through `kubectl`
    - compare with `ansible`, `ansible-playbook` commands!
- Settings (host name, credentials, etc: `kubeconfig`
    - compare with Ansible inventory file!

## Master Node

- API server
- Scheduler
- Controller Manager
    - Node controller: responsible for worker states
    - Replication controller: maintain correct number of pods for replicated controllers
    - Endpoint controller: join services & pods
    - Service account & token controller: access mgmt
- etcd: key/value store, e.g. scheduling info, node details

## Worker node

- `kubelet`: communicate with Master Node
- Run workloads
    - Container Engine (e.g. Docker, Podman)
    - Pods: smallest unit, tightly coupled containers
- Mount volumes
- Network routing (`kube-proxy`)
- ...

## Basic building blocks

- Pods
- Controllers:
    - Deployments, ReplicaSets, Services
    - DaemonSets, Jobs
- Organise applications:
    - Labels, Selectors, Namespaces

## Pods

- (Docker) App container(s)
- Storage resources
- Unique network IP
- Options that govern how container(s) should run

## Pods properties

- Ephemeral, disposable
- Never self-heal, not restarted by scheduler by itself
- Never create pods just by themselves
- Pro-tip: don't use pods directly, but controllers like a deployment

## Pod states

- Pending
- Running
- Succeeded - all containers exited with status 0
- Failed - all containers exited, at least one with exit status != 0
- CrashLoopBackOff - container fails to start, k8s tries over and over

## Controllers: ReplicaSets, Deployments, Services

- ReplicaSets
    - Ensure spec'd number of replicas for a pod are running
    - Used within a Deployment
- Deployments
    - Declarative updates for pods & ReplicaSets
    - Desired state in YAML file, k8s will bring pods to that state

## Controllers: Services

- Services
    - Allow communication between sets of deployments
    - Important: provides fixed ip, even if pod ip changes
    - Kinds:
        - Internal: IP only reachable within cluster
        - External: endpoint available throug ip:port (called NodePort)
        - Load Balancer: Expose app to internet with LB

## Controllers: Jobs, DaemonSets

- Jobs
    - Supervisor process for pods carrying out batch jobs
    - Individual processes that run once and complete successfully
    - Compare with cron job
- DaemonSets
    - Ensure that all nodes run a copy of a specific pod
    - E.g. when adding/removing nodes to the cluster
    - E.g. run single logging/monitoring agent on each node

## Organising applications: labels, selectors

- Labels:
    - key/value pairs, attached to objects (pods, services, deployments)
    - e.g. `"environment": "prod"`, `"tier": "backend"`, etc.
- Selectors:
    - identify set of objects, depending on label values
    - kinds:
        - equality-based: value = or !=
        - set-based: value in, not in, specific set, or value exists

## Organising applications: namespaces

- Namespaces
    - Verschillende clusters op zelfde hardware
    - Toegang regelen tussen verschillende gebruikers
    - Default namespace bij opstart cluster

# Kubernetes lab setup

## Get started with the lab assignment!

- Install `minikube` on your physical system
    - Use VirtualBox as the driver
- Install `kubectl`
- Start `minikube`
    - Install metrics server and dashboard plugins
- Optionally, add one or two extra nodes

## Follow instructions in the lab assignment

- Also keep a cheat sheet of important commands!
