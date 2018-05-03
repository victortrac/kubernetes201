#!/bin/bash

function pause() {
  echo -n "Enter to run: $@"
  read
  $@
}

pause kubectl create ns helm
pause kubectl create sa tiller -n helm
pause kubectl create clusterrolebinding tiller-cluster-admin  --clusterrole=cluster-admin --serviceaccount=helm:tiller
pause helm init --service-account tiller
