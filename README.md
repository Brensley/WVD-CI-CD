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

Before invoking the GitLab jobs that deploy the Base Control Plane or the JCP,
you must provide credentials for the target Kubernetes cluster. Retrieve the
kubeconfig from your provider, for example:

```bash
aws eks update-kubeconfig --name <cluster>
```

Copy the contents of the generated kubeconfig file and save them in a protected
GitLab CI variable named `KUBECONFIG_DATA`. The pipeline reads this variable to
authenticate against your cluster when applying manifests.
