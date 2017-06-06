#!/bin/bash

# Update & Upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove --purge -y

# Vim Config
echo "set number" >> ~/.vimrc

# Set SSL ROOT CA Certificate
sudo mkdir -p /usr/local/share/ca-certificates/wonderland
sudo cp CONFIG/wonderland-root-ca.crt /usr/local/share/ca-certificates/wonderland/
sudo chmod 644 /usr/local/share/ca-certificates/wonderland/wonderland-root-ca.crt
sudo update-ca-certificates

# Install Dependencies
sudo apt-get install python3-pip libssl-dev libffi-dev -y
pip3 install --upgrade pip

# Install Virtualenvwrapper | it will also make pip -> pip3
pip3 install --user virtualenvwrapper
echo "PATH=\"\$HOME/bin:\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "export WORKON_HOME=/mnt/d/DEV/VE" >> ~/.bashrc
echo ". ~/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc
. ~/.bashrc

# Install Ansible
mkvirtualenv Orchestrator
cdvirtualenv
pip install https://github.com/ansible/ansible/archive/devel.zip

# Set ansible.cfg
wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg
sed -i '/\/etc\/ansible\/hosts/s/#//' ansible.cfg
sed -i 's/\/etc\/ansible\/hosts/hosts/' ansible.cfg
echo "export ANSIBLE_CONFIG=/mnt/d/DEV/VE/Orchestrator/ansible.cfg" >> bin/postactivate
. bin/postactivate

# Set hosts
echo "$(hostname -I | awk '{print $1}') wonderland.local" | sudo tee -a /etc/hosts
echo "[windows]" >> hosts
echo "wonderland.local" >> hosts

# Install Windows Remote Management client
pip install https://github.com/diyan/pywinrm/archive/master.zip

# Set SSL ROOT CA for Ansible
cat /etc/ssl/certs/wonderland-root-ca.pem >> lib/python3.5/site-packages/certifi/cacert.pem

# Set connection
mkdir -p group_vars
echo "ansible_user: Express" >> group_vars/windows.yml
echo "ansible_password: W4t3rl00" >> group_vars/windows.yml
echo "ansible_port: 5986" >> group_vars/windows.yml
echo "ansible_connection: winrm" >> group_vars/windows.yml
echo "ansible_winrm_scheme: https" >> group_vars/windows.yml
echo "ansible_winrm_transport: ssl" >> group_vars/windows.yml
echo "ansible_winrm_server_cert_validation: validate" >> group_vars/windows.yml

# Test Ansible
ansible windows -m win_ping
