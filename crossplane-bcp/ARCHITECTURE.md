# Control Plane Architecture

This document summarizes the architecture principles referenced in the BCP/JCP deployment flowcharts. It focuses on how execution environments and trust zones interact within the control plane.

## Overview
The control plane (CP) orchestrates the provisioning of Execution Environments (EEs) and their Trust Zones (TZs). It also manages networking, RBAC and infrastructure lifecycles using Crossplane.

## Objectives
The JCWA Next-Gen Reference Design (JNeRD) aims to provide:

- **Multi‑tenant** infrastructure to support many organizations
- **Multi‑cloud and on‑prem** deployments
- **Self‑service** provisioning with minimal manual intervention

## Execution Environments
Each EE corresponds to a distinct mission or organization. Within an EE, multiple Trust Zones can be created on demand for teams or projects. Shared and Managed TZs are created automatically for shared services and managed JCP workloads.

## Trust Zones
Every TZ has its own network and RBAC boundaries. Networks connect transparently but traffic is controlled by policies. Project TZs are created as needed to isolate workloads for teams.

## Control Planes
The Base Control Plane (BCP) is a single‑node installation used to bootstrap the first JCP in air‑gapped environments. The Joint Control Plane (JCP) then manages downstream EEs and all of the resources described above.

### BCP Responsibilities
- Build and push Crossplane packages and Helm charts to an internal registry.
- Deploy an EKS cluster using Crossplane compositions.
- Install ArgoCD which deploys Keycloak, Backstage, Netbox and other services.

### JCP Responsibilities
- Provision workload EKS clusters via Crossplane.
- Manage application deployments via ArgoCD with charts stored in Harbor.

### Recommended Node Sizing
The BCP cluster uses a small NodeGroup to bootstrap the first JCP. A `t3.medium`
instance type with a 20GiB disk is sufficient for this control plane.

JCP workload clusters run ArgoCD, Harbor, Keycloak, and other services. These
clusters should use at least three `t3.large` worker nodes with 40GiB disks to
provide adequate capacity and redundancy for production deployments.
