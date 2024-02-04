#
# Doc(k)erfile
#
# unknown/unknown arch: https://github.com/orgs/community/discussions/45969
#
FROM ghcr.io/squidfunk/mkdocs-material:9.5.7 AS mkdocs-build
WORKDIR /src
COPY mkdocs.yml mkdocs.yml
COPY docs/ docs/
RUN mkdocs build --site-dir /src/site

FROM nginxinc/nginx-unprivileged:mainline-alpine3.18
LABEL org.opencontainers.image.source="https://github.com/duhio/homelab"
LABEL org.opencontainers.image.description="Homelab documentation container"
COPY --from=mkdocs-build /src/site /usr/share/nginx/html
