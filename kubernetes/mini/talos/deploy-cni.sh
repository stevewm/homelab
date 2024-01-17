#!/usr/bin/env bash
# shellcheck disable=2312
# source: bjw-s/home-ops
pushd cni >/dev/null 2>&1 || exit 1

rm -rf cni/charts
cp $(git rev-parse --show-toplevel)/kubernetes/mini/system/kube-system/cillium/app/values.yaml values.yaml
kustomize build --enable-helm . | kubectl apply -f -
rm values.yaml
rm -rf charts
