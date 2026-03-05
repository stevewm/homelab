#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

[private]
default:
    just -l nas

alias mc := minecraft
[doc('Minecraft rcon')]
minecraft: (rcon "minecraft" "games")

alias vs := vintagestory
[doc('Vintage Story rcon')]
vintagestory: (rcon "vintagestory" "games")

[private]
rcon name ns type="rcon" project="homelab":
    just log info "Opening rcon connection to {{ name }} in namespace {{ ns }}..." && \
    rcon --address $(kubectl -n "{{ ns }}" get svc "{{ name }}" -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):\
    $(kubectl -n "{{ ns }}" get svc "{{ name }}" -o jsonpath='{.spec.ports[?(@.name=="rcon")].port}') \
      --password $(doppler secrets get {{ uppercase(name) }}_RCON_PASSWORD -p {{ project }} --plain) --type {{ type }}
