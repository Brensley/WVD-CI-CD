# Crossplane BCP Deployment

This directory houses the resources required to build and deploy the Base Control Plane (BCP) and the downstream JCP using Crossplane. The folder structure mirrors the flow diagrams described in the architecture documentation.

```
crossplane-bcp/
├── ARCHITECTURE.md           # High level architecture overview
├── build/
│   ├── providerConfigs/      # Crossplane providers and configs
│   └── services/             # Configuration services bundled as xpkg
├── config-bundle/            # Bundle combining services and providers
├── functions/
│   ├── git-reader/           # Function package to read Git repos
│   └── object-reader/        # Function package to read cluster objects
├── helm/
│   ├── helm-base/            # Base Helm chart
│   └── helm-jcrs-jcp/        # Helm chart for JCRS/JCP workloads
├── clusters/
│   ├── bcp/                  # Manifests to install the BCP
│   └── jcp/                  # Manifests to install the JCP
```

## GitLab CI Pipeline
The root `.gitlab-ci.yml` builds Crossplane packages and Helm charts and pushes them to the registry defined by `DEV_REGISTRY`. These packages are then pulled and deployed by the CLI as shown in the flowcharts.

Refer to [ARCHITECTURE.md](ARCHITECTURE.md) for more background on execution environments, trust zones and control plane concepts.
