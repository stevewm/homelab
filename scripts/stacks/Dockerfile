# hadolint global ignore=DL4006,DL3008
FROM ghcr.io/astral-sh/uv:debian-slim

WORKDIR /

COPY . .
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates curl gnupg && \
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
    apt-get update && apt-get install -y --no-install-recommends doppler && \
    apt-get install -y --no-install-recommends bash git doppler && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    uv python install

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
