# Crossplane BCP Deployment


This directory houses the resources required to build and deploy the Base Control Plane (BCP) and the downstream JCP using Crossplane. The folder structure mirrors the flow diagrams described in the architecture documentation.

```
crossplane-bcp/
├── ARCHITECTURE.md           # High level architecture overview
├── build/
│   ├── providerConfigs/      # Crossplane providers and configs
│   └── services/             # Compositions and Helm releases
│       └── compositions/     # EKS cluster definition and composition
├── config-bundle/            # Bundle combining services and providers
├── jcp-config-bundle/        # Bundle for the JCP installation
=======
This directory contains the files and folder structure for deploying the Base Cluster Platform (BCP) and JCP clusters using Crossplane. The flow follows the diagrams provided and uses a GitLab CI pipeline to build and push Crossplane packages.

```
crossplane-bcp/
├── build/
│   ├── providerConfigs/      # Crossplane provider and provider configs
│   └── services/             # Configuration services bundled as xpkg
├── config-bundle/            # Bundle combining services and providers
├── functions/
│   ├── git-reader/           # Function package to read Git repos
│   └── object-reader/        # Function package to read cluster objects
├── helm/
│   ├── helm-base/            # Base Helm chart
│   └── helm-jcrs-jcp/        # Helm chart for JCRS/JCP workloads
├── scripts/                  # Teardown helpers
├── clusters/
│   ├── bcp/                  # Manifests to install the BCP
│   └── jcp/                  # Manifests to install the JCP
```

## GitLab CI Pipeline
The root `.gitlab-ci.yml` builds Crossplane packages and Helm charts and pushes them to the registry defined by `DEV_REGISTRY`. These packages are then pulled and deployed by the CLI as shown in the flowcharts.

Optional `destroy_bcp` and `destroy_jcp` jobs call scripts in `scripts/` to tear down clusters when scheduled.

Refer to [ARCHITECTURE.md](ARCHITECTURE.md) for more background on execution environments, trust zones and control plane concepts.
=======
│   └── helm-jcrs-jcp/        # Helm chart for JCRS/JCP
├── clusters/
│   ├── bcp/                  # Manifests to install BCP cluster
│   └── jcp/                  # Manifests to install JCP cluster
└── README.md
```

The `.gitlab-ci.yml` file in the repo root builds these packages and pushes them to the OCI registry defined by `DEV_REGISTRY`.

