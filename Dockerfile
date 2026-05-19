FROM ubuntu:latest
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
RUN mkdir /code && \
    chown -R 65532:65532 /code && \
    echo "code:x:65532:65532:code:/code:/bin/bash" >> /etc/passwd && \
    echo "code:x:65532:" >> /etc/group && \
    echo "code ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/code && \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R 65532:65532 /home/linuxbrew
USER 65532:65532
ENV HOME=/code
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew \
    HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar \
    HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew/Homebrew \
    PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH
WORKDIR /code
CMD ["/usr/bin/code", "tunnel"]
