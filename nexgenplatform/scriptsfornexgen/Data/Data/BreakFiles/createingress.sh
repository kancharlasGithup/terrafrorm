#!/bin/bash
read -p "Enter Name Space :" tenant
echo $tenant
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
