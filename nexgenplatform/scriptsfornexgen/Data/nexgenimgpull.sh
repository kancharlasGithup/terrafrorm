#!/bin/bash
read -p "Enter new registry name    :" registryname
echo $registryname

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-webui:n3xgen0.49
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-webui:n3xgen0.49 $registryname/cnp-webui:n3xgen0.49
sudo docker push $registryname/cnp-webui:n3xgen0.49
sudo docker rmi -f $registryname/cnp-webui:n3xgen0.49
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-webui:n3xgen0.49

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-adminservice:n3xgen0.22
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-adminservice:n3xgen0.22 $registryname/cnp-adminservice:n3xgen0.22
sudo docker push $registryname/cnp-adminservice:n3xgen0.22
sudo docker rmi -f $registryname/cnp-adminservice:n3xgen0.22
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-adminservice:n3xgen0.22

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-git:nexgen711.2
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-git:nexgen711.2 $registryname/cnp-git:nexgen711.2
sudo docker push $registryname/cnp-git:nexgen711.2
sudo docker rmi -f $registryname/cnp-git:nexgen711.2
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-git:nexgen711.2

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-jenkins:nexgen711.1
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-jenkins:nexgen711 $registryname/cnp-jenkins:nexgen711.1
sudo docker push $registryname/cnp-jenkins:nexgen711.1
sudo docker rmi -f $registryname/cnp-jenkins:nexgen711.1
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-jenkins:nexgen711.1

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-keycloak:cnpkeycloak0.2
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-keycloak:cnpkeycloak0.2 $registryname/cnp-keycloak:cnpkeycloak0.2
sudo docker push $registryname/cnp-keycloak:cnpkeycloak0.2
sudo docker rmi -f $registryname/cnp-keycloak:cnpkeycloak0.2
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/cnp-keycloak:cnpkeycloak0.2

sudo docker pull 155363134060.dkr.ecr.us-west-2.amazonaws.com/cnp-mongo:1.5.2
sudo docker tag 155363134060.dkr.ecr.us-west-2.amazonaws.com/cnp-mongo:1.5.2 $registryname/cnp-mongo:1.5.2
sudo docker push $registryname/cnp-mongo:1.5.2
sudo docker rmi -f $registryname/cnp-mongo:1.5.2
sudo docker rmi -f 155363134060.dkr.ecr.us-west-2.amazonaws.com/cnp-mongo:1.5.2

sudo docker pull 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:7.3.0
sudo docker tag 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:7.3.0 $registryname/elasticsearch-client:7.3.0
sudo docker push $registryname/elasticsearch-client:7.3.0
sudo docker rmi -f $registryname/elasticsearch-client:7.3.0
sudo docker rmi -f 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:7.3.0

sudo docker pull 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:pass1.1
sudo docker tag 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:pass1.1 $registryname/elasticsearch-data:pass1.1
sudo docker push $registryname/elasticsearch-data:pass1.1
sudo docker rmi -f $registryname/elasticsearch-data:pass1.1
sudo docker rmi -f 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:pass1.1

sudo docker pull 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:7.3.0
sudo docker tag 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:7.3.0 $registryname/elasticsearch-master:7.3.0
sudo docker push $registryname/elasticsearch-master:7.3.0
sudo docker rmi -f $registryname/elasticsearch-master:7.3.0
sudo docker rmi -f 155363134060.dkr.ecr.us-west-2.amazonaws.com/elasticsearch:7.3.0

sudo docker pull 155363134060.dkr.ecr.us-west-2.amazonaws.com/grafana:test0.7
sudo docker tag 155363134060.dkr.ecr.us-west-2.amazonaws.com/grafana:test0.7 $registryname/grafana:test0.7
sudo docker push $registryname/grafana:test0.7
sudo docker rmi -f $registryname/grafana:test0.7
sudo docker rmi -f 155363134060.dkr.ecr.us-west-2.amazonaws.com/grafana:test0.7

sudo docker pull 155363134060.dkr.ecr.us-west-2.amazonaws.com/kibana:version7.3.0
sudo docker tag 155363134060.dkr.ecr.us-west-2.amazonaws.com/kibana:version7.3.0 $registryname/kibana:version7.3.0
sudo docker push $registryname/kibana:version7.3.0
sudo docker rmi -f $registryname/kibana:version7.3.0
sudo docker rmi -f 155363134060.dkr.ecr.us-west-2.amazonaws.com/kibana:version7.3.0

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/ldap:cnpldap0.1
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/ldap:cnpldap0.1 $registryname/ldap:cnpldap0.1
sudo docker push $registryname/ldap:cnpldap0.1
sudo docker rmi -f $registryname/ldap:cnpldap0.1
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/ldap:cnpldap0.1