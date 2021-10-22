#!/bin/bash
tenant=$9
tennatDomain=${12}
domain=${10}
DNS=${10}
servicename=$1
image=$2
tag=$3
instances=$4
helmchart=ishelm
mws=mywebmethodsserver
umb=universalmessaging
apigwy=apigateway
apiportal=apiportal
cc=commandcentral
mql=mysql
mcr=microservicesruntime

Service1=$5
Service2=$6
Service3=$7
Service4=${11}
Service5=${13}
Service6=${14}

mwsservice=""
umservice=""
isservice=""
mysqlservice=""
apiishost=""

#env=$8

if [ "$Service1" == "undefined" ]
then

    umservice="localhost"
else
    umservice=$Service1
fi

if [ "$Service2" == "undefined" ]
then

    mwsservice="localhost"
else
    mwsservice=$Service2
fi


if [ "$Service3" == "undefined" ]
then

    isservice="localhost"
else
    isservice=$Service3
fi

if [ "$Service4" == "undefined" ]
then

    mysqlservice="mysql-ser"
else
    mysqlservice=$Service4
fi


if [[ $image == *"integrationserver"* ]] ; then
rsync /usr/src/site/$TENANT_NAME /root/.kube/config
val="mongo-0"
kubectl exec $val -c mongo -- mongo --eval "conn = new Mongo(); db = db.getSiblingDB('$servicename'); load(\"/data/test.js\");"
fi

nfsServerPath=/var/nfsshare/$servicename
nfspathconfig=""
nfspathconf="" 
nfsServer=10.90.143.137
wmdataserverpath=/var/nfsshare/$servicename
wmdatanfsprivateip=10.90.143.137
wmdatanfspublicip=20.80.190.17


sleep 5

ns1=$8
ns2="QA"
ns3="Production"
#export TILLER_NAMESPACE=$ns1

if [ "$ns1" == "$ns2" ]
then
    #export TILLER_NAMESPACE=$tenant
    rsync /usr/src/site/$tenant /root/.kube/config
     echo "then-qa"
elif [ "$ns1" == "$ns3" ]
then
    #export TILLER_NAMESPACE=$tenant
    rsync /usr/src/site/$tenant /root/.kube/config
     echo "else-prod"
else
    #export TILLER_NAMESPACE=$tenant
    rsync /usr/src/site/$tenant /root/.kube/config
     echo "else-dev"
fi


if [[ $image == *"mywebmethodsserver"* ]] ; then
  helmchart=mwshelm
  echo "mws helm"
fi
if [[ $image == *"universalmessaging"* ]] ; then
  helmchart=umbhelm
  ssh -i /usr/src/site/nfsserver.key.pem  azureuser@20.80.190.17 "sudo mkdir $nfsServerPath && exit"
  echo "umb helm"
fi
if [[ $image == *"apigateway"* ]] ; then
  helmchart=apigatewayhelm
  apiishost=$servicename-is
  echo "apigwy helm"
fi
if [[ $image == *"microservicesruntime"* ]] ; then
  helmchart=microserviceshelm
  echo "mcr helm"
fi
if [[ $image == *"apiportal"* ]] ; then
  helmchart=apiportalhelm
  echo "apiportal helm"
fi
if [[ $image == *"commandcentral"* ]] ; then
  helmchart=cchelm
  echo "cc helm"
fi
if [[ $image == *"mysql"* ]] ; then
  helmchart=mysqlhelm
  ssh -i /usr/src/site/nfsserver.key.pem  azureuser@20.80.190.17 "sudo mkdir $nfsServerPath && exit"
  echo "mql helm"
fi


typeofhelm="ishelm"

if [ "$helmchart" == "$typeofhelm" ] ; then
  ssh -i /usr/src/site/nfsserver.key.pem  azureuser@20.80.190.17 "sudo mkdir $nfsServerPath && sudo mkdir $nfsServerPath/$servicename-packages && sudo mkdir $nfsServerPath/$servicename-config && sudo mkdir $nfsServerPath/$servicename-conf && exit"
  nfspathconfig=$nfsServerPath/$servicename-config
  nfspathconf=$nfsServerPath/$servicename-conf
  nfsServerPath=$nfsServerPath/$servicename-packages
  ssh -i /usr/src/site/nfsserver.key.pem  azureuser@$wmdatanfspublicip "sudo mkdir $wmdataserverpath/$servicename-wmdata && exit"
  wmdataserverpath=$wmdataserverpath/$servicename-wmdata
fi

echo "Helm chart used:${helmchart}"

# Creates route 53 record

#helm delete $servicename --purge
helm install $servicename /root/deploy/$helmchart --set fullnameOverride=$servicename,nameOverride=$servicename,image.repository=$image,image.tag=$tag,service.hosts=$servicename.$DNS,replicaCount=$instances,myWebMethod=$mwsservice,universalMessaging=$umservice,envValue=$2,integrationServer=$isservice,mysqlServer=$mysqlservice,apiIsHost=$apiishost.$DNS,nfsPath=$nfsServerPath,service.nfsServer=$nfsServer,nfspathconfig=$nfspathconfig,nfspathconf=$nfspathconf,wmdataserverpath=$wmdataserverpath,service.wmdatanfsprivateip=$wmdatanfsprivateip

sleep 10
#export TILLER_NAMESPACE=$tenant
#rsync /usr/src/site/cnp-dev /root/.kube/config
