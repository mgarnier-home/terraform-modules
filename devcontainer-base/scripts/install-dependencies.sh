#!/bin/bash

cat <<EOF > ~/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
$SSH_PRIVATE_KEY
-----END OPENSSH PRIVATE KEY-----
EOF
chmod 600 ~/.ssh/id_rsa
sudo service ssh start

echo "${ADDITIONAL_WORKSPACE_FOLDERS}"
echo "${GIT_REPOS}"


# if [ -f /setup/setup-env.sh ]; then
#   echo "Running setup-env.sh"
#   /setup/setup-env.sh
# fi

# if [ -f /setup/get-workspace-file.sh ]; then
#   echo "Running get-workspace-file.sh"
#   bash /setup/get-workspace-file.sh "${ADDITIONAL_WORKSPACE_FOLDERS}"  > ~/workspace.code-workspace
# fi





