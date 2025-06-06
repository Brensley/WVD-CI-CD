# Crossplane BCP Deployment

This directory contains the assets needed to build the Base Control Plane (BCP) and the JCP clusters using Crossplane.
The layout below mirrors the structure expected by the GitLab pipeline defined in the repository root.

```
crossplane-bcp/
├── ARCHITECTURE.md           # Overview of the control plane design
├── build/
│   ├── providerConfigs/      # Crossplane provider definitions
│   └── services/             # Service compositions and Helm charts
│       └── compositions/     # EKS cluster definition and composition
├── config-bundle/            # BCP configuration bundle
├── jcp-config-bundle/        # JCP configuration bundle
├── functions/
│   ├── git-reader/           # Upbound function for reading Git repos
│   └── object-reader/        # Upbound function for reading cluster objects
├── helm/
│   ├── helm-base/            # Base Helm chart
│   └── helm-jcrs-jcp/        # Helm chart for JCRS/JCP workloads
├── clusters/
│   ├── bcp/                  # Manifests to install the BCP cluster
│   └── jcp/                  # Manifests to install the JCP cluster
├── scripts/                  # Teardown helpers
└── README.md
```

The `.gitlab-ci.yml` file at the repo root packages these resources and pushes them to the container registry specified by `DEV_REGISTRY`.
Optional jobs invoke the scripts in `scripts/` to destroy the BCP or JCP clusters when scheduled.

See [ARCHITECTURE.md](ARCHITECTURE.md) for additional details about execution environments and trust zones.

