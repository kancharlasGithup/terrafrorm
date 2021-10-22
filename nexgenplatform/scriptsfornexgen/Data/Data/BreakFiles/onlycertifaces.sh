#!/bin/bash
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