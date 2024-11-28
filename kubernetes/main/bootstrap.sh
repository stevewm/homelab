#!/usr/bin/env bash

# bootstrap cluster

jp2a $(git rev-parse --show-toplevel)/docs/logo.png --colors --term-fit --fill --clear

## secrets
### doppler api token
doppler run -p homelab -c prd --only-secrets DOPPLER_API_TOKEN --command 'kubectl create secret generic doppler \
                                                  --from-literal=token=$DOPPLER_API_TOKEN --namespace=flux-system'
## config
### cluster variables
kubectl apply -f ./flux/vars.yaml

## bootstrap flux
mkdir -p bootstrap/
VERSION=$(yq e 'select(documentIndex == 0) | .spec.ref.tag' flux/config/flux.yaml)
cat <<EOF > bootstrap/kustomization.yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/fluxcd/flux2/manifests/install?ref=$VERSION
EOF
gum spin --spinner line --title "Bootstrapping Flux... this may take a while" -- kubectl apply --kustomize ./bootstrap/
rm -rf bootstrap/

## flux
kubectl apply --kustomize flux/config
