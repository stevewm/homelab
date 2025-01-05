#
# Doc(k)erfile
#
# unknown/unknown arch: https://github.com/orgs/community/discussions/45969
#

FROM ghcr.io/squidfunk/mkdocs-material:9.5.49@sha256:ba73db5ab937632760a59742ba89e199ca6122cfad4ca21d1f27125fefa31a33 AS mkdocs-build
WORKDIR /src

COPY . .

RUN pip install -r docs/requirements.txt
RUN mkdocs build --site-dir /src/site


FROM nginxinc/nginx-unprivileged:mainline-alpine3.18@sha256:7b4316677e4015a53d326e657915340128d9fd506f826f676d9f169c0c8557f6
LABEL org.opencontainers.image.source="https://github.com/stevewm/homelab"
LABEL org.opencontainers.image.description="Homelab documentation container"
COPY --from=mkdocs-build /src/site /usr/share/nginx/html
