#!/bin/bash

function download() {
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml -o 01-namespace.yaml
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml -o 02-default-backend.yaml
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml -o 05-configmap.yaml
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml -o 06-tcp-services-configmap.yaml
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml -o 07-udp-services-configmap.yaml
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml -o 10-rbac.yaml
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/patch-service-with-rbac.yaml -o 11-daemonset.yaml
  sed -i \
      -e 's!apiVersion: extensions/v1beta1!apiVersion: apps/v1beta2!' \
      -e 's!kind: Deployment!kind: DaemonSet!' \
      -e '/^[[:space:]]*replicas*/d' \
      11-daemonset.yaml
}

function install_base() {
  for resource in {0,1}*.yaml; do
    echo "Applying ${resource}..."
    kubectl apply -f ${resource}
  done
}

function install_gke() {
  local ENV=$1

  ## sets up nginx for use in GCP/GKE
  curl -s https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/gce-gke/service.yaml -o 20-gke-service.yaml
  kubectl apply -f 20-gke-service.yaml

  # adds DaemonSet Rolling Update configuration
  kubectl patch daemonset -n ingress-nginx nginx-ingress-controller --type='json' \
    --patch="$(cat 99-cloudkite-patch-daemonset.yaml)"

  # patch to increase nginx read timeout, enable vts status
  echo "Installing cloudkite patches..."
  kubectl patch configmap -n ingress-nginx nginx-configuration --type='json' \
    --patch="$(cat 99-cloudkite-patch-configmap.yaml)"

  # Environment specific patches
  if [ -f "99-cloudkite-${ENV}-patch-configmap.yaml" ]; then
    echo "Installing ${ENV} patches..."
    kubectl patch configmap -n ingress-nginx nginx-configuration --type='json' \
      --patch="$(cat 99-cloudkite-${ENV}-patch-configmap.yaml)"
  fi
}

function patch_gcp_rbac() {
  # gcloud user needs to be bound to k8s cluster-admin to grant nginx some privileges
  local USER=$(gcloud config get-value account)
  kubectl create clusterrolebinding $(echo ${USER} | cut -d@ -f1)-cluster-admin-binding --clusterrole=cluster-admin --user=${USER}
}

function main() {
  ACTION=$1
  ENV=$2

  case "${ACTION}" in
    download)
      download
      ;;
    install_gke)
      patch_gcp_rbac
      install_base
      install_gke "${ENV}"
      ;;
    *)
      echo $"Usage: $0 {download|install_gke}"
      exit 1
  esac
}

main $@
