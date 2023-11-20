# Home Lab Repo

This repo contains the configuration and documentation for a self-hosted Kubernetes (k3s) cluster that I run at home.

## Hardware

The cluster consists of:

- 4x Raspberry Pi 4B 8GB
- 4x WaveShare PoE HAT (E)
- 4x 1TB SDD
- 1x NETGEAR PoE 5-port switch
- 1x UCTRONICS Pi Cluster Case

## Setting up

The playbooks in the `ansible` directory are used to configure the cluster hardware (package dependencies, etc) and install K3s.

The cluster configuration is then bootstrapped by using `task bootstrap` to apply the manifests in `kubernetes/bootstrap`, along with applying the manifests in `kubernetes/flux/config` which configures flux to watch `kubernetes/flux` and `kubernetes/apps` for changes and apply them to the cluster.

## Inspiration

Inspired by [bjw-s/home-ops](https://github.com/bjw-s/home-ops), [geerlingguy/pi-cluster](https://github.com/geerlingguy/pi-cluster) and the [k8s-at-home](https://github.com/topics/k8s-at-home) community.
