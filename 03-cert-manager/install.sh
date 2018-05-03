#!/bin/bash

function pause() {
  echo -n "Enter to run: $@"
  read
  $@
}

pause helm install --name cert-manager --namespace cert-manager stable/cert-manager 
pause kubectl create -f cert-manager-issuer-staging.yaml
pause kubectl create -f cert-manager-issuer-prod.yaml
