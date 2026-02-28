#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

# Cluster bootstrapping
mod k8s-bootstrap "cluster/bootstrap"
# Cluster management
mod k8s "cluster/kubernetes"
# Talos bootstrapping & management
mod talos "cluster/talos"
# NAS management
mod nas "nas"
# VPS management
mod? vps "vps"

[private]
default:
    echo -e "\033[32m$(cat {{ justfile_dir() }}/docs/assets/.homelab.txt)\033[0m"
    just -l

[private]
log lvl msg *args:
  gum log -t rfc3339 -s -l "{{ lvl }}" "{{ msg }}" {{ args }}

[private]
template doppler_proj file *args:
    doppler secrets download --no-fallback --no-file --format json --project "{{ doppler_proj }}" | minijinja-cli -f json "{{ absolute_path(file) }}" - {{ args }}

[doc('Set up environment')]
setup:
    @which jq mise doppler hk code
    mise install
    @if ! doppler whoami > /dev/null 2>&1; then doppler login; fi
    rm -rf {{ justfile_dir() }}/.github/hooks # https://github.com/jdx/hk/issues/113
    hk install
    @for ext in $(jq -r '.recommendations[]' {{ justfile_dir() }}/.vscode/extensions.json); do \
        code --install-extension "$ext" --force; \
    done
