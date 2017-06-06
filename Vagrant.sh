# Install Virtualbox
echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" | sudo tee -a /etc/apt/sources.list.d/virtualbox.list
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc -q -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-5.1 -y

# Install Vagrant
wget https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5_x86_64.dmg
sudo dpkg -i vagrant_1.9.5_x86_64.deb