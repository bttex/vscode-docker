FROM ghcr.io/gitpod-io/openvscode-server:latest

USER root
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copiar o arquivo de extensões
COPY extensoes.txt /tmp/extensoes.txt

# Instalar as extensões do VS Code
RUN while IFS= read -r extension || [[ -n "$extension" ]]; do \
    if [[ ! "$extension" =~ ^# && -n "$extension" ]]; then \
    echo "Installing extension: $extension" && \
    /usr/bin/code-server --install-extension "$extension"; \
    fi \
    done < /tmp/extensoes.txt