#!/usr/bin/env bash

# bootstrap cluster

# flux install
kubectl apply -f https://github.com/fluxcd/flux2/manifests/install?ref=v2.2.2

# secrets
declare -a secrets=("SOPS_AGE_KEY" "HOMELAB_REPO_GITHUB_TOKEN")

for secret_name in "${secrets[@]}"
do
    # Use the secret name in the Doppler command
    doppler run -p homelab -c prd --only-secrets "$secret_name" --command "kubectl create secret generic github --from-literal=token=\$$secret_name"
done

# flux configuration
kubectl apply --kustomize flux/config
