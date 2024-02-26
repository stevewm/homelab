#!/usr/bin/env bash
helmfile apply --skip-diff-on-install --suppress-diff --file talos/integrations/helmfile.yaml
