#!/bin/bash

# Apply updates using apt
sudo apt update
sudo apt-get dist-upgrade -y

# Create systemd service override for walinuxagent
sudo mkdir -p /etc/systemd/system/walinuxagent.service.d
echo "[Unit]" > /etc/systemd/system/walinuxagent.service.d/override.conf
echo "After=cloud-final.service" >> /etc/systemd/system/walinuxagent.service.d/override.conf
sudo sed "s/After=multi-user.target//g" /lib/systemd/system/cloud-final.service > /etc/systemd/system/cloud-final.service
sudo systemctl daemon-reload

# Install required software
sudo apt-get install dirmngr gnupg apt-transport-https ca-certificates -y

# Install Mono from official repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install mono-complete -y

# Install Microsoft package repository and .NET SDKs
wget "https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb" -O /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb
sudo apt update
sudo apt-get install unzip -y
sudo apt-get install dotnet-sdk-5.0 -y
sudo apt-get install dotnet-sdk-6.0 -y
sudo apt-get install dotnet-sdk-7.0 -y
sudo apt-get install dotnet-sdk-8.0 -y
rm /tmp/packages-microsoft-prod.deb

# Install additional software packages
sudo apt-get install docker-ce docker-ce-cli python3 nodejs npm -y

# Install mono-devel package
sudo apt-get install mono-devel -y

# Add user to the 'docker' group
sudo usermod -aG docker $USER
sudo snap install kubelogin
echo "hello kirit updated" > /tmp/test
