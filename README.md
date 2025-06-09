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

The `.gitlab-ci.yml` pipeline builds, pushes and now deploys the Crossplane configuration. To execute the pipeline end-to-end:

1. Set `DEV_REGISTRY` to the container registry where packages should be pushed. The default value in `.gitlab-ci.yml` is `registry.example.com/dev`, but you must replace this with the URL of your actual registry (GitLab registry, ECR, etc.) for the push stage to succeed.
2. Provide a `KUBECONFIG_DATA` variable in GitLab CI containing credentials for the target Kubernetes cluster.
3. Trigger the pipeline. After the push stage completes, the `deploy_bcp` and `deploy_jcp` jobs apply the manifests under `crossplane-bcp/clusters/` using `kubectl`.


### Extracting the kubeconfig

To populate the `KUBECONFIG_DATA` variable, capture the kubeconfig for the cluster you wish to deploy to. Depending on your provider you can use commands such as:

```bash
aws eks update-kubeconfig --name <cluster>
az aks get-credentials --resource-group <rg> --name <cluster>
kubectl config view --minify --raw > kubeconfig
```

Open the resulting file and paste its contents into the `KUBECONFIG_DATA` variable in GitLab CI.
