FROM ubuntu:jammy 

# Install baseline packages
RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
    apt-transport-https \
    bash \
    bash-completion \
    build-essential \
    ca-certificates \
    cifs-utils \
    curl \
    dmidecode \
    gnupg-agent \
    gpg \
    htop \
    iputils-ping \
    jq \
    lm-sensors \
    locales \
    man \
    nano \
    openssh-server \
    p7zip-full \
    pciutils \
    python3 \
    python3-pip \
    software-properties-common \
    sudo \
    unzip \
    util-linux \
    vim \
    wget \
    rsync \
    && \
# Install latest Git using their official PPA
    add-apt-repository ppa:git-core/ppa && \
    apt-get install --yes git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
RUN apt-get update && apt-get install --no-install-recommends -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# SSH server configuration
ARG SSHD_PORT=2222
RUN sed -i \
    -e "s/^#\(Port\) .*/\1 ${SSHD_PORT}/" \ 
    /etc/ssh/sshd_config && \
    mkdir /run/sshd

RUN systemctl enable ssh

EXPOSE ${SSHD_PORT}

# Make typing unicode characters in the terminal work.
ENV LANG=en_US.UTF-8
ARG USER=coder


# Setup the entrypoint
ARG CODER_INIT_SCRIPT="echo 'Hello from Coder!'"
RUN mkdir -p /setup 
COPY ./scripts /setup
RUN \
  echo "${CODER_INIT_SCRIPT}" > /setup/entrypoint.sh && \
  sed -i "1a sudo bash /setup/additional-entrypoint.sh" /setup/entrypoint.sh

  

# Create a non-root user
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER} \
  && sudo usermod -aG docker ${USER}

RUN chown -R ${USER}:${USER} /setup && \
  chmod +x /setup/*.sh

USER ${USER}
WORKDIR /home/${USER}

# Setup user home directory and SSH keys
COPY ssh .ssh
ARG WORKSPACE_FILE_B64=""
RUN sudo chown -R ${USER}:${USER} .ssh && \
  sudo chmod 700 .ssh && \
  sudo chmod 600 .ssh/*
#   cat \
# -----BEGIN OPENSSH PRIVATE KEY----- \
# ${SSH_PRIVATE_KEY} \
# -----END OPENSSH PRIVATE KEY----- \
#   > ~/.ssh/id_rsa && \
  


# Zsh Installation
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.0/zsh-in-docker.sh)" && \
  sudo chsh -s /usr/bin/zsh $USER
SHELL ["/usr/bin/zsh", "-c"]


# Tasks Installation
ARG INSTALL_TASKS=false
RUN \
  if [ "${INSTALL_TASKS}" = "true" ]; then \
    sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b .local; \
    echo "export PATH=\$PATH:~/.local" >> ~/.zshrc; \
  fi

# Coder CLI Installation
ARG INSTALL_CODER_CLI=false
RUN \
  if [ "${INSTALL_CODER_CLI}" = "true" ]; then \
    curl -L https://coder.com/install.sh | sh; \
    echo "Coder Installed"; \
  fi


# GO Installation
ARG INSTALL_GO=false
RUN \
  if [ "${INSTALL_GO}" = "true" ]; then \
    curl -o go.tar.gz https://dl.google.com/go/go1.22.4.linux-amd64.tar.gz; \
      sudo tar -C /usr/local -xzf go.tar.gz; \
      rm go.tar.gz; \
      echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.zshrc; \
    echo "Go Installed"; \
  fi

# NVM Installation
ARG INSTALL_NVM=false
RUN \
  if [ "${INSTALL_NVM}" = "true" ]; then \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; \
    echo "NVM Installed"; \
    source ~/.zshrc; \
    nvm install 20; \
  fi


# Ansible Installation
ARG INSTALL_ANSIBLE=false
RUN \
  if [ "${INSTALL_ANSIBLE}" = "true" ]; then \
    sudo add-apt-repository --yes --update ppa:ansible/ansible; \
    sudo DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris apt-get install -y ansible; \
    echo "Ansible Installed"; \
  fi


VOLUME [ "/mnt/dev" ]

ENTRYPOINT ["/setup/entrypoint.sh"]