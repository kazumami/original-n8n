FROM docker.n8n.io/n8nio/n8n:stable
USER root
RUN ARCH=$(uname -m) && \
    wget -qO- "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/" | \
    grep -o 'href="apk-tools-static-[^"]*\.apk"' | head -1 | cut -d'"' -f2 | \
    xargs -I {} wget -q "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/{}" && \
    tar -xzf apk-tools-static-*.apk && \
    ./sbin/apk.static add --no-cache poppler-utils font-noto-cjk && \
    rm -rf apk-tools-static-*.apk sbin/apk.static
RUN cd /usr/local/lib/node_modules/n8n/node_modules/.pnpm/@n8n+task-runner*/node_modules/@n8n/task-runner && npm install --no-save @e2b/code-interpreter
USER node
