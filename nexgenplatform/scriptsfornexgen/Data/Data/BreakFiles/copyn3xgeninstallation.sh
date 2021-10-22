#!/bin/bash
read -p "Enter Name Space :" namespace
echo $namespace
read -p "Enter Resource Group :" resource_group
echo $resource_group
read -p "Enter Cluster Name :" cluster_name
echo $cluster_name
read -p "Enter tenant Name :" tenant
echo $tenant
read -p "Enter domain Name :" domain
echo $domain
read -p "Enter SUBSCRIPTIONID :" SubscriptionID
echo $SubscriptionID
read -p "Enter TenantID :" tenantID
echo $tenantID
read -p "Enter user Name :" Username
echo $Username
read -p "Enter password :" Password
echo $Password
read -p "Enter nfsserverIP :" nfsserverip
echo $nfsserverip
read -p "Enter ingress domain name :" ingressdomain
echo $ingressdomain
#installing azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#installing helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
#installing oc cli and kubectl cli
echo "***** Checking For Openshift Client *****"
echo
if [ -e oc ]
then
	echo "Openshift Client Already Exists"
else
	echo "Openshift Client Doesn't Exists!! Downloading the Openshift Client"
	echo

	wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz

	tar -xvf openshift-client-linux.tar.gz oc

fi
sudo cp oc /usr/local/bin
echo "***** Checking For Openshift Client *****"
echo
if [ -e kubectl ]
then
	echo "Kubernetes Client Already Exists"
else
	echo "Kubernetes Client Doesn't Exists!! Downloading the Kubernetes Client"
	echo
tar -xvf openshift-client-linux.tar.gz kubectl
fi
sudo cp kubectl /usr/local/bin

#Nfs installation and configuration
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

echo "Executing n3xgen creation script"
bash copyn3xgencreation.sh $namespace $resource_group $cluster_name $tenant $domain $SubscriptionID $tenantID $Username $Password $nfsserverip $ingressdomain
echo "Executing certificate creation script"
bash copycertificate.sh $namespace $resource_group $cluster_name $tenant $domain $SubscriptionID $tenantID $Username $Password $nfsserverip $ingressdomain
