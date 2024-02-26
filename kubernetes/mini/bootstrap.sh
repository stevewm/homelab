#!/usr/bin/env bash

# bootstrap cluster

## bootstrap flux
jp2a $(git rev-parse --show-toplevel)/docs/logo.png --colors --term-fit --fill --clear

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


## secrets
### Doppler API Token
doppler run -p homelab -c prd --only-secrets DOPPLER_API_TOKEN --command 'kubectl create secret generic doppler \
                                                  --from-literal=token=$DOPPLER_API_TOKEN --namespace=flux-system'

## flux
kubectl apply --kustomize flux/config
