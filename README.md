# Kubernetes 201: You have a cluster, now what?
This repo contains code from my "Kubernetes 201" talk.

Slides are available [here](https://docs.google.com/presentation/d/1d0YnMflbvHHcFkAqq_5S-2s5pqnEEWfOzwi9MiuUF_c/edit?usp=sharing).

## What's here
These are some of the basics that a production-ready kubernetes cluster may have:

* Nginx ingress controller
* [Helm/Tiller](https://github.com/kubernetes/helm) package management
* Jetstack's [cert-manager](https://github.com/jetstack/cert-manager) for automatically generating TLS certs
* Prometheus, Grafana, and AlertManager
* Elasticsearch + Fluentd + Kibana for log management

*Disclaimer*: All of these resources require downloading things off of the internet, and things in the world of Kubernetes in a constant state of flux. Things may or may not work, but I will try to maintain this repo.  Pull requests and issues are welcome!


## How to use this repo
Each of these directories contains some kubernetes YAML definitions as well as a `install.sh` bash file. The `install.sh` is simply just a wrapper around ordered shell commands that run `kubectl`, etc. Take a look at `install.sh` instead of just blindly running it. 
