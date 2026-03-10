ARG N8N_VERSION=stable
FROM docker.n8n.io/n8nio/n8n:${N8N_VERSION}

USER root

RUN apt-get update && apt-get install -y \
    poppler-utils \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

USER node
