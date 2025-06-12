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

The `.gitlab-ci.yml` file at the repo root builds the required packages and then installs them directly from the generated `.xpkg` files. Optional jobs invoke the scripts in `scripts/` to destroy the BCP or JCP clusters when scheduled.

The pipeline contains a `deploy` stage. `deploy_bcp` installs the Base Control Plane using `kubectl crossplane install` for each package. `deploy_jcp` installs the JCP bundle in the same way, and `apply_clusterclaim` provisions an EKS cluster from `clusters/jcp/clusterclaim.yaml`. These jobs require the `KUBECONFIG_DATA` variable to be set with credentials for the target Kubernetes cluster.

The ClusterClaim manifest also defines NodeGroup sizing parameters. Adjust the `instanceType`, `diskSize`, and `desiredSize` values to suit your environment before running the pipeline.

The pipeline also contains a `deploy` stage. `deploy_bcp` installs the Base Control Plane by applying `clusters/bcp/crossplane.yaml`, then `deploy_jcp` installs the JCP using the manifests under `clusters/jcp/`.
These jobs require the `KUBECONFIG_DATA` variable to be set with credentials for the target Kubernetes cluster.
Retrieve the kubeconfig using your provider's CLI, for example:
```bash
aws eks update-kubeconfig --name <cluster>
```
Paste the file's contents into the GitLab CI variable `KUBECONFIG_DATA`.
Ensure Crossplane is already installed on that cluster before triggering the deploy jobs.

See [ARCHITECTURE.md](ARCHITECTURE.md) for additional details about execution environments and trust zones.
