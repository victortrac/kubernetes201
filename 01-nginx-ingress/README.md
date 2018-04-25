# nginx-ingress controller with custom patches

## Download latest definitions from Kubernetes upstream

```bash
./install.sh download
```

This downloads the latest upstream k8s resource definitions from github.com/kubernetes/nginx-ingress and will save the files like this:

  * 01-namespace.yaml
  * 02-default-backend.yaml
  * 05-configmap.yaml
  * 06-tcp-services-configmap.yaml
  * 07-udp-services-configmap.yaml
  * 10-rbac.yaml
  * 11-daemonset.yaml

## Make any modifications necessary to YAML patch files
`install.sh` looks for files like 99-cloudkite\*.yaml.

See [JSON Patch Syntax](http://jsonpatch.com/).

## Install on GKE

```bash
./install.sh install_gke
```

This will install all of the upstream kubernetes resources and then apply GKE & Cloudkite patches.
