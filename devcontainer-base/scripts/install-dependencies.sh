#!/bin/bash

cat <<EOF > ~/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
$SSH_PRIVATE_KEY
-----END OPENSSH PRIVATE KEY-----
EOF
chmod 600 ~/.ssh/id_rsa
sudo service ssh start

# Zsh Installation
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.0/zsh-in-docker.sh)"
printf "ZSH Installed\n"

# Task Installation
echo "INSTALL_TASKS: ${INSTALL_TASKS}"
if [ "${INSTALL_TASKS}" = "true" ]; then
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b .local && \
    echo "export PATH=\$PATH:~/.local" >> ~/.zshrc
  echo "Task Installed"
fi

# Coder Installation
echo "INSTALL_CODER: ${INSTALL_CODER}"
if [ "${INSTALL_CODER}" = "true" ]; then
  curl -L https://coder.com/install.sh | sh
  echo "Coder Installed"
fi

# Go Installation
echo "INSTALL_GO: ${INSTALL_GO}"
if [ "${INSTALL_GO}" = "true" ]; then
  curl -o go.tar.gz https://dl.google.com/go/go1.22.4.linux-amd64.tar.gz && \
    sudo tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz && \
    echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.zshrc
  echo "Go Installed"
fi

# NVM Installation
echo "INSTALL_NVM: ${INSTALL_NVM}"
if [ "${INSTALL_NVM}" = "true" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  echo "NVM Installed"
fi

# Ansible Installation
echo "INSTALL_ANSIBLE: ${INSTALL_ANSIBLE}"
if [ "${INSTALL_ANSIBLE}" = "true" ]; then
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris apt-get install -y ansible
  echo "Ansible Installed"
fi

sudo chsh -s /usr/bin/zsh $USER

if [ -f /setup/setup-env.sh ]; then
  echo "Running setup-env.sh"
  /setup/setup-env.sh
fi

if [ -f /setup/get-workspace-file.sh ]; then
  echo "Running get-workspace-file.sh"
  bash /setup/get-workspace-file.sh "${ADDITIONAL_WORKSPACE_FOLDERS}"  > ~/workspace.code-workspace
fi



