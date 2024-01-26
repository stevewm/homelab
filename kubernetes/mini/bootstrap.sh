#!/usr/bin/env bash

# bootstrap cluster

## bootstrap flux
echo "Bootstrapping flux, takes a little while to download the manifests..."
mkdir -p bootstrap/
VERSION=$(yq e 'select(documentIndex == 0) | .spec.ref.tag' flux/config/flux.yaml)
cat <<EOF > bootstrap/kustomization.yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - github.com/fluxcd/flux2/manifests/install?ref=$VERSION
EOF

kubectl apply --kustomize ./bootstrap/
rm -rf bootstrap/


# ## secrets
doppler run -p homelab -c prd --only-secrets SOPS_AGE_KEY --command 'kubectl create secret generic github \
                                                                         --from-literal=age.agekey=$SOPS_AGE_KEY'

doppler run -p homelab -c prd --only-secrets HOMELAB_REPO_GITHUB_TOKEN --command 'kubectl create secret generic github \
                                                                                    --from-literal=token=$HOMELAB_REPO_GITHUB_TOKEN'

## flux
kubectl apply --kustomize flux/config
