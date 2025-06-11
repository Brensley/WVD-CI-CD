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

### Recommended NodeGroup Sizes

- **BCP NodeGroup:** `t3.medium` instances with 50Gi disks.
- **JCP NodeGroup:** `t3.large` instances with 100Gi disks and a desired size of three nodes to run ArgoCD, Harbor and Keycloak workloads.

The `diskSize` parameter can be omitted if the default EKS volume size is
sufficient, but the values above provide a good starting point for most
installations.

### AWS Prerequisites

The EKS composition in `build/services/compositions/eks-composition.yaml`
exposes parameters for IAM roles and subnet IDs so you can supply values from
your AWS account when deploying the control plane:

- `controlPlaneRoleArn` &mdash; IAM role used by the EKS control plane.
- `nodeRoleArn` &mdash; IAM role for the BCP NodeGroup.
- `nodeSubnetIds` &mdash; subnet IDs for the BCP nodes.
- `jcpNodeRoleArn` &mdash; IAM role for the JCP NodeGroup.
- `jcpSubnetIds` &mdash; subnet IDs for the JCP nodes.

Provide these parameters along with `instanceType` and `diskSize` to
match the recommended sizes above.
