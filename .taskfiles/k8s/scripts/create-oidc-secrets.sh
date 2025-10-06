#!/usr/bin/env bash

set -eou pipefail

AUTHELIA_OUTPUT=$(docker run --rm authelia/authelia:latest authelia crypto hash generate pbkdf2 \
    --variant sha512 \
    --random \
    --random.length 72 \
    --random.charset rfc3986 | tr '\n' ',' | sed 's/,$//')

APP_CLIENT_SECRET=$(echo "$AUTHELIA_OUTPUT" | awk -F'Random Password: |,Digest:' '{print $2}')
APP_CLIENT_SECRET_DIGEST=$(echo "$AUTHELIA_OUTPUT" | awk -F'Digest: ' '{print $2}')

echo "Setting secrets for $APP"
doppler secrets set "${APP}_OAUTH_CLIENT_SECRET" "$APP_CLIENT_SECRET" --project homelab
doppler secrets set "${APP}_OAUTH_CLIENT_SECRET_DIGEST" "$APP_CLIENT_SECRET_DIGEST" --project homelab
