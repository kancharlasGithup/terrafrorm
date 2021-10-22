#!/bin/bash
sudo apt install nfs-kernel-server -y
sudo mkdir /var/nfsshare
sudo chmod -R 755 /var/nfsshare 
sudo systemctl enable rpcbind  
sudo systemctl enable nfs-server 
sudo systemctl start rpcbind  
sudo systemctl start nfs-server
sudo useradd -d /home/nfsnobody nfsnobody
sudo chown nfsnobody:nfsnobody /var/nfsshare
sudo mkdir /var/nfsshare/git 
sudo mkdir /var/nfsshare/buildis 
sudo mkdir /var/nfsshare/buildis103 
sudo mkdir /var/nfsshare/ci 
sudo mkdir /var/nfsshare/kc 
sudo mkdir /var/nfsshare/mongo 
sudo mkdir /var/nfsshare/mysql 
sudo mkdir /var/nfsshare/varldap 
sudo mkdir /var/nfsshare/etcldap
sudo mkdir /var/nfsshare/buildis107