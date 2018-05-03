#!/bin/bash

function pause() {
  echo -n "Enter to run: $@"
  read
  $@
}

pause helm install --name prometheus --namespace monitoring -f prometheus.values.yaml stable/prometheus
pause kubectl apply -f rbac.yaml
pause helm install --name grafana --namespace monitoring -f grafana.values.yaml stable/grafana
