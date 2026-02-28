#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

mod k8s-bootstrap "cluster/bootstrap"
mod k8s "cluster/kubernetes"
mod talos "cluster/talos"
mod nas "nas"

[private]
default:
    just -l

[private]
log lvl msg *args:
  gum log -t rfc3339 -s -l "{{ lvl }}" "{{ msg }}" {{ args }}

[private]
template doppler_proj file *args:
    doppler secrets download --no-fallback --no-file --format json --project "{{ doppler_proj }}" | minijinja-cli -f json "{{ absolute_path(file) }}" - {{ args }}
