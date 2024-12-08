#!/usr/bin/env bash

set -e

# STACKS_DIR is the directory within $GIT_REPO that contains the stack definitions
# GIT_REPO is the URL of the repo that will be cloned (or updated) to get the stack definitions
#
# Envsubst is run against each env.yaml.tmpl file in each stack directory to create the env.yaml file


CLONE_DIR=${CLONE_DIR:-/repo}

# Clone the repo
if [ -d "$CLONE_DIR" ]; then
  echo "Repo already exists, updating"
  cd "$CLONE_DIR"
  git pull
else
  echo "Cloning repo"
  git clone "$GIT_REPO" "$CLONE_DIR"
  cd "$CLONE_DIR"
fi

pwd

# shellcheck disable=SC2086,SC2154,SC2016
doppler run -- sh -c 'for f in $(find $STACKS_DIR -name env.tmpl); do envsubst < $f > $(dirname $f)/.env; done'
uv run /main.py
