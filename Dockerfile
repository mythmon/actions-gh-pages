FROM node:10-slim

LABEL version="0.1.0"
LABEL repository="https://github.com/mythmon/actions-gh-pages"
LABEL homepage="https://github.com/mythmon/actions-gh-pages"
LABEL maintainer="Michael Cooper <mythmon@gmail.com>"

LABEL com.github.actions.name="GitHub Action for gh-pages"
LABEL com.github.actions.description="Uses gh-pages to deploy a static site to Github Pages."
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="#327fc7"
COPY LICENSE README.md /

RUN apt-get update && \
    apt-get install --yes --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*
COPY "entrypoint.js" "/entrypoint.js"

RUN yarn add gh-pages

ENTRYPOINT ["/entrypoint.js"]
