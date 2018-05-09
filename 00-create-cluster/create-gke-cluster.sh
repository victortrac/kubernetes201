#!/bin/bash

gcloud beta container --project "kubernetes201" clusters create "cluster-1" \
  --addons HorizontalPodAutoscaling,KubernetesDashboard \
  --cluster-version "1.9.7-gke.0" \
  --disk-size "100" \
  --enable-autorepair
  --enable-autoscaling \
  --enable-cloud-logging \
  --enable-cloud-monitoring \
  --enable-network-policy \
  --image-type "COS" \
  --machine-type "n1-standard-1" \
  --max-nodes "3" \
  --min-nodes "1" \
  --network "default" \
  --no-enable-basic-auth \
  --num-nodes "1" \
  --preemptible \
  --region "us-central1" \
  --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --subnetwork "default" \

