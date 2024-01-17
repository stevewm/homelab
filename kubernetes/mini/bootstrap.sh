#!/usr/bin/env bash

# bootstrap cluster

# # flux install
kubectl apply -f https://github.com/fluxcd/flux2/manifests/install?ref=v2.2.2

# # secrets
doppler run -p homelab -c prd --only-secrets SOPS_AGE_KEY --command 'kubectl create secret generic github \
                                                                        --from-literal=age.agekey=$SOPS_AGE_KEY'
doppler run -p homelab -c prd --only-secrets HOMELAB_REPO_GITHUB_TOKEN --command 'kubectl create secret generic github \
                                                                        --from-literal=token=$HOMELAB_REPO_GITHUB_TOKEN'

# # flux
kubectl apply --kustomize flux/config
