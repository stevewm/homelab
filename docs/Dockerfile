#
# Doc(k)erfile
#
# unknown/unknown arch: https://github.com/orgs/community/discussions/45969
#

FROM ghcr.io/squidfunk/mkdocs-material:9.5.47 AS mkdocs-build
WORKDIR /src

COPY . .

RUN pip install -r docs/requirements.txt
RUN mkdocs build --site-dir /src/site


FROM nginxinc/nginx-unprivileged:mainline-alpine3.18
LABEL org.opencontainers.image.source="https://github.com/stevewm/homelab"
LABEL org.opencontainers.image.description="Homelab documentation container"
COPY --from=mkdocs-build /src/site /usr/share/nginx/html
