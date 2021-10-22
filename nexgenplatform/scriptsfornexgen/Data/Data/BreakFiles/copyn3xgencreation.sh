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
nfsserverip=${10}
echo $nfsserverip
ingressdomain=${11}
echo $ingressdomain

#login to azure with service-principal
az login --service-principal -u $Username --password $Password --tenant $tenantID
#login to AKS cluster
az account set --subscription $SUBSCRIPTIONID
az aks get-credentials --resource-group $resource_group --name $cluster_name
#Creating Namespace with Tenant Name Specified
kubectl create namespace $namespace
kubectl config set-context --current --namespace=$namespace
kubectl patch namespace $namespace -p '{"metadata":{"annotations":{"scheduler.alpha.kubernetes.io/node-selector":"name=n3xgenDev"}}}'
kubectl config set-context --current --namespace=$namespace
#installation docker
sudo apt install docker.io -y
#Login to AZURE ACR Registry
sudo docker login cgacr711.azurecr.io -u $Username -p $Password
#Copy the Docker Config to Current Working Directory
sudo cp /home/azadmin/.docker/config.json ./config.json
sudo chmod 755 config.json
#Adding the Image Pull Secret for this tenant
oc create secret generic myregistrykey --from-file=.dockerconfigjson=config.json --type=kubernetes.io/dockerconfigjson -n $namespace
oc secrets link default myregistrykey --for=pull -n $namespace
#oc create secret generic myregistrykey --from-file=.dockerconfigjson=config.json --type=kubernetes.io/dockerconfigjson -n dev
#oc secrets link default myregistrykey --for=pull -n dev
#Providing the Cluster role to user
oc adm policy add-cluster-role-to-user cluster-admin admin
#Allowing Containers in this project to run with anyuserid
oc adm policy add-scc-to-user anyuid -z default -n $namespace
oc adm policy add-scc-to-user privileged -z default -n $namespace
#Creating Tenant Speicific Secrets with Tenant Name and Domain name
oc create secret generic tenant-secret --from-literal=tenant_name=$tenant --from-literal=domain=$domain
oc create secret generic grafana-secret --from-literal=ROOT=https://grafana.$tenant.$domain --from-literal=DNS_value=grafana.$tenant.$domain --from-literal=AUTH_value=https://auth.$tenant.$domain/auth/realms/Nextgen/protocol/openid-connect/auth --from-literal=TOKEN_value=https://auth.$tenant.$domain/auth/realms/Nextgen/protocol/openid-connect/token --from-literal=API_value=https://auth.$tenant.$domain/realms/Nextgen/protocol/openid-connect/userinfo

oc create secret generic portal-secret --from-literal=graphql_url=https://graphql.$tenant.$domain/graphql --from-literal=gitlab_url=https://git.$tenant.$domain --from-literal=gitlab_token=bMisACjWsU6Uiah3b8N --from-literal=gitlab_credentials=root:admin123@ --from-literal=jenkins_port=8080 --from-literal=jenkins_host=https://ci.$tenant.$domain --from-literal=jenkins_auth=YWRtaW46MTE2YzU4ODBiZTZiMTRkYTAxMWU2YjQwNGQzZTVmZWE2MA== --from-literal=adminservice_url=https://admin.$tenant.$domain/ --from-literal=source_IS=https://is.$tenant.$domain --from-literal=my_DNS=.$tenant.$domain --from-literal=Author_Name=nextgenuser --from-literal=Author_Email=hafsah.rajgoli@cloudgensys.com --from-literal=mongo_Host=mongodb://mongo:27017 --from-literal=db_name=CNPDB --from-literal=Deployer_WM=https://is.$tenant.$domain --from-literal=Deployer_WM_Authorization=QWRtaW5pc3RyYXRvcjptYW5hZ2U --from-literal=Local_Port=80 --from-literal=node_url=https://node.$tenant.$domain --from-literal=Keycloak_realm=Nextgen --from-literal=Keycloak_url=https://auth.$tenant.$domain/auth --from-literal=Keycloak_client=cnp-dev-web --from-literal=Kibana_url=https://kibana.$tenant.$domain --from-literal=Grafana_url=https://grafana.$tenant.$domain --from-literal=graphql_port=8080 --from-literal=frontend_port=5008 --from-literal=node_port=5005 --from-literal=cluster_url=https://api.cm.changemaker.community:6443/ --from-literal=cluster_token=cYuMel62jRIEEjXY62DN_FBrfPMMW-yTHpRjO_kgCvI --from-literal=cluster_namespace=$tenant --from-literal=aws_region=us-west-1 --from-literal=aws_accesskey=AKIASILC5JJWC56XHNWQ --from-literal=aws_secretkey=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 --from-literal=dns=$tenant.$domain --from-literal=tenant_dev=dev --from-literal=tenant_qa=qa --from-literal=tenant_prod=prod --from-literal=adminservice_port=5002 --from-literal=vm_client=$tenant --from-literal=tenant=$tenant --from-literal=giturl_jenkins=https://root:admin123@git.$tenant.$domain/ --from-literal=Elastic_url=https://elastic.$tenant.$domain --from-literal=Build_IS=https://is.$tenant.$domain --from-literal=mongo_hostname=mongo.$tenant.svc --from-literal=mongo_pass=manage --from-literal=react_app_url=https://web.$tenant.$domain --from-literal=react_app_is103=https://is103.$tenant.$domain --from-literal=react_app_is105=https://is.$tenant.$domain --from-literal=react_app_cluster=711 --from-literal=azapp_id=375d1c25-3a96-4070-a360-7dbb8405fc78 --from-literal=az_password=HxRE.L7_tQWjX7jxD7PFONCBQFTUBjkc_t --from-literal=az_tenant=d0de88a5-d208-4dfe-bc1a-c492aa862d7e --from-literal=react_app_is107=https://is107.$tenant.$domain

oc create secret generic elasticsearch-pw-elastic --from-literal password=elastic
dn=$(echo $tenant.$domain|sed 's/\./,dc=/g; s/^/dc=/')
ldapserver=$tenant.$domai


oc create secret generic ldap-secret --from-literal=dn=$dn --from-literal=ldapserver=$ldapserver
kubectl create namespace dev
kubectl patch namespace dev -p '{"metadata":{"annotations":{"scheduler.alpha.kubernetes.io/node-selector":"env=dev"}}}'
kubectl config set-context --current --namespace=dev
mkdir -m 755 kubeconfigs
oc create secret generic myregistrykey --from-file=.dockerconfigjson=config.json --type=kubernetes.io/dockerconfigjson -n dev
oc secrets link default myregistrykey --for=pull -n dev

oc create sa devsa
oc adm policy add-role-to-user admin -z devsa
oc sa create-kubeconfig 'devsa' >./kubeconfigs/devkc

cd kubeconfigs
kubectl config set-context --current --namespace=$namespace
kubectl create configmap sakubeconfigs --from-file=dev=devkc

cd ../
#Deploying all the NextGen Platform services
#sed -i "s/10.35.248.4/'$nfsserverip'/g" n3xgen-deployment-v1.yaml
sed -i "s/10.35.248.4/$nfsserverip/g" n3xgendeployment.yaml
sed -i "s/10.35.248.4/$nfsserverip/g" webmethodsdeployment.yaml
sed -i "s/10.35.248.4/$nfsserverip/g" elkdeployment.yaml


#oc create -f n3xgen-deployment-v1.yaml -n $namespace
oc create -f n3xgendeployment.yaml -n $namespace
oc create -f webmethodsdeployment.yaml -n $namespace
oc create -f elkdeployment.yaml -n $namespace
