#!/usr/bin/env bash
helmfile apply --skip-diff-on-install --suppress-diff --file integrations.yaml
