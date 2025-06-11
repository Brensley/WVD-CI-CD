# Repository Overview

This repository contains automation to deploy Windows Virtual Desktop (WVD) resources and a Crossplane-based control plane. The directory layout is organized as follows:

```
FSlogix/            - Script to install the FSLogix agent
GoldImage/          - Scripts used to build a Windows gold image
Notepadplusplus/    - Example script for installing Notepad++
crossplane-bcp/     - Crossplane packages and GitLab CI pipeline for the Base Control Plane (BCP) and JCP
mainTemplate.json   - ARM template for creating a new WVD host pool
UpdateTemplate.json - ARM template for updating an existing host pool
packer-win10_1903.json,
packer-win10_1909.json - Packer definitions for building Windows images
.gitlab-ci.yml      - CI pipeline for building and publishing Crossplane packages
```

Refer to `crossplane-bcp/README.md` for detailed instructions on deploying the BCP and JCP using Crossplane. The original blog post on automating WVD with Azure DevOps can be found [here](https://bit.ly/2Qj8kfe).

## Running the Pipeline

The `.gitlab-ci.yml` pipeline builds and then deploys the Crossplane configuration directly from the generated `.xpkg` files. To run it end-to-end:

1. Provide a `KUBECONFIG_DATA` variable in GitLab CI containing credentials for the target Kubernetes cluster.
2. Trigger the pipeline. After the build stage completes, the `deploy_bcp`, `deploy_jcp`, and `apply_clusterclaim` jobs install each package using `kubectl crossplane install` and then apply the `ClusterClaim` manifest.
   Edit `crossplane-bcp/clusters/jcp/clusterclaim.yaml` if your environment requires a different region or Kubernetes version before running the pipeline.

