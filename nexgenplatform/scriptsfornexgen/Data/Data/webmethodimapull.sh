#!/bin/bash
read -p "Enter new registry name    :" registryname
echo $registryname

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:b2bis_10.7.5
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:b2bis_10.7.5 $registryname/webmethods/integrationserver:b2bis_10.7.5
sudo docker push $registryname/webmethods/integrationserver:b2bis_10.7.5
sudo docker rmi -f $registryname/webmethods/integrationserver:b2bis_10.7.5
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:b2bis_10.7.5

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server10.7.3
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server10.7.3 $registryname/webmethods/integrationserver:build_server10.7.3
sudo docker push $registryname/webmethods/integrationserver:build_server10.7.3
sudo docker rmi -f $registryname/webmethods/integrationserver:build_server10.7.3
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server10.7.3

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server1.7
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server1.7 $registryname/webmethods/integrationserver:build_server1.6
sudo docker push $registryname/webmethods/integrationserver:build_server1.6
sudo docker rmi -f $registryname/webmethods/integrationserver:build_server1.6
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server1.7

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server10.3.5
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server10.3.5 $registryname/webmethods/integrationserver:build_server10.3.5
sudo docker push $registryname/webmethods/integrationserver:build_server10.3.5
sudo docker rmi -f $registryname/webmethods/integrationserver:build_server10.3.5
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/integrationserver:build_server10.3.5

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/mywebmethodsserver:mws_10.7.1
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/mywebmethodsserver:mws_10.7.1 $registryname/webmethods/mywebmethodsserver:mws_10.7.1
sudo docker push $registryname/webmethods/mywebmethodsserver:mws_10.7.1
sudo docker rmi -f $registryname/webmethods/mywebmethodsserver:mws_10.7.1
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/mywebmethodsserver:mws_10.7.1

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/universalmessaging-server:10.7.1
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/universalmessaging-server:10.7.1 $registryname/webmethods/universalmessaging-server:10.7.1
sudo docker push $registryname/webmethods/universalmessaging-server:10.7.1
sudo docker rmi -f $registryname/webmethods/universalmessaging-server:10.7.1
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/webmethods/universalmessaging-server:10.7.1

sudo docker pull 155363134060.dkr.ecr.us-west-1.amazonaws.com/mysql:10.7
sudo docker tag 155363134060.dkr.ecr.us-west-1.amazonaws.com/mysql:10.7 $registryname/webmethods/mysql:10.7
sudo docker push $registryname/webmethods/mysql:10.7
sudo docker rmi -f $registryname/webmethods/mysql:10.7
sudo docker rmi -f 155363134060.dkr.ecr.us-west-1.amazonaws.com/mysql:10.7





