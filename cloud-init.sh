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

#aks-chargerapps-uat-01
sudo echo "172.18.96.4 aks-v1cbfmyo.acb471d6-b215-493e-a1cb-7de32affa6fe.privatelink.canadacentral.azmk8s.io" >> /etc/hosts

#aks-chargerfleet-prod-scus-003
sudo echo "172.25.144.4 aks-z4uobfrd.c0620094-3d10-4da0-94a0-dff646c1fcf9.privatelink.southcentralus.azmk8s.io" >> /etc/hosts

#aks-chargerfleet-prod-eastus-002
sudo echo "172.26.144.4 aks-y859bgiz.08987325-0f80-4114-8106-721046066747.privatelink.eastus.azmk8s.io" >> /etc/hosts

