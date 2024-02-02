#
# Doc(k)erfile
#
FROM python:3.9-bullseye AS mkdocs-build
RUN pip install mkdocs-material mkdocs-material[imaging]
WORKDIR /src
COPY mkdocs.yml mkdocs.yml
COPY docs/ docs/
RUN mkdocs build --site-dir /src/site

FROM nginx:stable-alpine
COPY --from=mkdocs-build /src/site /usr/share/nginx/html
