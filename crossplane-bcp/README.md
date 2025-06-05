# Crossplane BCP Deployment

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
│   └── helm-jcrs-jcp/        # Helm chart for JCRS/JCP
├── clusters/
│   ├── bcp/                  # Manifests to install BCP cluster
│   └── jcp/                  # Manifests to install JCP cluster
└── README.md
```

The `.gitlab-ci.yml` file in the repo root builds these packages and pushes them to the OCI registry defined by `DEV_REGISTRY`.
