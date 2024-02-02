#
# Doc(k)erfile
#
FROM python:3.12-bullseye AS mkdocs-build
RUN pip install mkdocs-material mkdocs-material[imaging]
WORKDIR /src
COPY mkdocs.yml mkdocs.yml
COPY docs/ docs/
RUN mkdocs build --site-dir /src/site

FROM nginx:stable-alpine
LABEL org.opencontainers.image.source="https://github.com/duhio/homelab"
COPY --from=mkdocs-build /src/site /usr/share/nginx/html
