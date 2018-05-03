#!/bin/bash

function pause() {
  echo -n "Enter to run: $@"
  read
  $@
}

export TILLER_NAMESPACE='helm'

pause kubectl create ns ${TILLER_NAMESPACE}
pause kubectl create sa tiller -n ${TILLER_NAMESPACE}
pause kubectl create clusterrolebinding tiller-cluster-admin  --clusterrole=cluster-admin --serviceaccount=${TILLER_NAMESPACE}:tiller
pause helm init --tiller-namespace ${TILLER_NAMESPACE} --service-account tiller
