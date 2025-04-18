FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        gnupg \
        jq \
        openssh-client \
        procps \
        python3-venv \
        unzip \
        vim \
        wget \
        yq \
        && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/packages.microsoft.gpg && \
    echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list && \
    apt-get update && \
    apt-get install -y code && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir /code && \
    chown -R 65532:65532 /code && \
    echo "code:x:65532:65532:code:/code:" > /etc/passwd && \
    echo "code:x:65532:" >> /etc/group

USER 65532:65532
WORKDIR /code/data

CMD ["/usr/bin/code", "tunnel"]
