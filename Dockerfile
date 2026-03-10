FROM alpine:3.21 AS alpine

FROM docker.n8n.io/n8nio/n8n:stable

COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /lib/ld-musl-*.so.1 /lib/
COPY --from=alpine /lib/libapk.so.* /lib/
COPY --from=alpine /etc/apk /etc/apk
COPY --from=alpine /lib/apk /lib/apk

USER root
RUN apk add --no-cache \
    poppler-utils \
    font-noto-cjk \
 && rm -rf /var/cache/apk/*
USER node
