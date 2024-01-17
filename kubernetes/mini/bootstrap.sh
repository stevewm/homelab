#!/usr/bin/env bash

# bootstrap cluster

# # flux install
kubectl apply --kustomize bootstrap/

# # secrets
sops --decrypt bootstrap/age-key.sops.yaml | kubectl apply -f -
sops --decrypt bootstrap/github-key.sops.yaml | kubectl apply -f -

# # flux
kubectl apply --kustomize flux/config
