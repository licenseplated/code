FROM ubuntu:26.04
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        file \
        git \
        gnupg \
        jq \
        libldap2-dev \
        libsasl2-dev \
        openssh-client \
        procps \
        python3-dev \
        python3-venv \
        screen \
        sudo \
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
RUN mkdir -p /home/mmz && \
    chown -R 65532:65532 /home/mmz && \
    echo "mmz:x:65532:65532:mmz:/home/mmz:/bin/bash" >> /etc/passwd && \
    echo "mmz:x:65532:" >> /etc/group && \
    echo "code ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/code && \
    mkdir -p /home/linuxbrew && \
    chown -R 65532:65532 /home/linuxbrew
USER 65532:65532
ENV HOME=/home/mmz
WORKDIR /home/mmz
CMD ["/usr/bin/code", "tunnel"]
