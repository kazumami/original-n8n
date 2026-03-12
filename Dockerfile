FROM docker.n8n.io/n8nio/n8n:stable
USER root
RUN ARCH=$(uname -m) && \
    wget -qO- "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/" | \
    grep -o 'href="apk-tools-static-[^"]*\.apk"' | head -1 | cut -d'"' -f2 | \
    xargs -I {} wget -q "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/{}" && \
    tar -xzf apk-tools-static-*.apk && \
    ./sbin/apk.static add --no-cache poppler-utils font-noto-cjk && \
    rm -rf apk-tools-static-*.apk sbin/apk.static
RUN mkdir -p /opt/custom-nodes && cd /opt/custom-nodes && npm install @e2b/code-interpreter
RUN TASK_RUNNER_DIR=$(find /usr/local/lib/node_modules/n8n/node_modules/.pnpm -path '*/@n8n/task-runner/node_modules' -type d | head -1) && \
    ln -s /opt/custom-nodes/node_modules/@e2b "$TASK_RUNNER_DIR/@e2b"
USER node
