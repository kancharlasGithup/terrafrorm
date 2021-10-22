#!/bin/bash

namespace=$1
echo $namespace
resource_group=$2
echo $resource_group
cluster_name=$3
echo $cluster_name
tenant=$4
echo $tenant
domain=$5
echo $domain
SubscriptionID=$6
echo $SubscriptionID
tenantID=$7
echo $tenantID
Username=$8
echo $Username
Password=$9
echo $Password
nfsserverip=$10
echo $nfsserverip
ingressdomain=$11
echo $ingressdomain


#helm repo add stable https://charts.helm.sh/stable
#helm install prometheus stable/prometheus-operator --namespace $namespace

sudo apt install unzip -y 
unzip acme.sh.zip

#echo
#Creating the HTTPS Ceritificates for Tenant's Sub-Domain
#echo "##### Creating Certificates for the Cluster and Tenant $tenant #####"
export AZUREDNS_SUBSCRIPTIONID=$SubscriptionID
export AZUREDNS_TENANTID=$tenantID
export AZUREDNS_APPID=$Username
export AZUREDNS_CLIENTSECRET=$Password
chmod 755 -R acme.sh
acme.sh/acme.sh --issue -d *.$tenant.$domain --dns dns_azure
mkdir $tenant
sleep 5
acme.sh/acme.sh --install-cert -d *.$tenant.$domain --cert-file $tenant/cert.pem --key-file $tenant/key.pem --fullchain-file $tenant/fullchain.pem --ca-file $tenant/ca.cer
sleep 5
cd $tenant
#Installing the above Created Certificates to the Router
oc create secret tls tls-secret --cert=fullchain.pem --key=key.pem -n $namespace
oc create secret tls cnp-tls --cert=fullchain.pem --key=key.pem -n dev
#oc create secret tls cnp-tls --cert=fullchain.pem --key=key.pem -n qa

# Creating ingress for services
#sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" ingressnexgen.yaml
#oc create -f ingressnexgen.yaml -n $tenant

sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" adminingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" buildis103ingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" elasticsearchingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" grafanaingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" graphqa.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" is105ingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" is107ingress.yml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" jenkinsingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" keycloak.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" kibanaingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" nodeingress.yaml
sed -i "s/nexgen.711.n3xgen.io/$ingressdomain/g" webingress.yaml

oc create -f adminingress.yaml -n $tenant
oc create -f buildis103ingress.yaml -n $tenant
oc create -f elasticsearchingress.yaml -n $tenant
oc create -f grafanaingress.yaml -n $tenant
oc create -f graphqa.yaml -n $tenant
oc create -f is105ingress.yaml -n $tenant
oc create -f is107ingress.yml -n $tenant
oc create -f jenkinsingress.yaml -n $tenant
oc create -f keycloak.yaml -n $tenant
oc create -f kibanaingress.yaml -n $tenant
oc create -f nodeingress.yaml -n $tenant
oc create -f webingress.yaml -n $tenant