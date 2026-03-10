ARG N8N_VERSION=stable
FROM docker.n8n.io/n8nio/n8n:${N8N_VERSION}

USER root

RUN apk add --no-cache \
    poppler-utils \
    font-noto-cjk

USER node
