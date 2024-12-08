#!/usr/bin/env bash

set -e

CLONE_DIR=${CLONE_DIR:-/repo}
GIT_BRANCH=${GIT_BRANCH:-main}

# Clone the repo
if [ -d "$CLONE_DIR" ]; then
  echo "Repo already exists, updating"
  cd "$CLONE_DIR"
  git pull origin "$GIT_BRANCH"
else
  echo "Cloning repo"
  git clone -b "$GIT_BRANCH" "$GIT_REPO" "$CLONE_DIR"
  cd "$CLONE_DIR"
fi

# shellcheck disable=SC2086,SC2154,SC2016
doppler run -- sh -c 'for f in $(find $STACKS_DIR -name env.tmpl); do envsubst < $f > $(dirname $f)/.env; done'
uv run /main.py
