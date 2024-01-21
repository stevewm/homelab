#!/usr/bin/env bash
# shellcheck disable=2312

# credit to bjw-s/homeops

pushd integrations >/dev/null 2>&1 || exit 1

K8S_ROOT=$(git rev-parse --show-toplevel)/kubernetes/${CLUSTER_NAME}

rm -rf cni/charts
envsubst < $K8S_ROOT/infrastructure/kube-system/cilium/app/values.yaml > cni/values.yaml
kustomize build --enable-helm cni | kubectl apply -f -
rm cni/values.yaml
rm -rf cni/charts

rm -rf kubelet-csr-approver/charts
envsubst < $K8S_ROOT/infrastructure/system/kubelet-csr-approver/app/values.yaml > kubelet-csr-approver/values.yaml
if ! kubectl get ns system >/dev/null 2>&1; then
  kubectl create ns system
fi
kustomize build --enable-helm kubelet-csr-approver | kubectl apply -f -
rm kubelet-csr-approver/values.yaml
rm -rf kubelet-csr-approver/charts
