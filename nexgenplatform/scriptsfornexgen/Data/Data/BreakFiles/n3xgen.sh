#!/bin/bash
sed -i "s!cgacr711.azurecr.io/711!sktestmaincrn.azurecr.io/sktestmain711!g" n3xgendeployment.yaml
sed -i "s!cgacr711.azurecr.io/711!sktestmaincrn.azurecr.io/sktestmain711!g" elkdeployment.yaml
sed -i "s!cgacr711.azurecr.io/711!sktestmaincrn.azurecr.io/sktestmain711!g" webmethodsdeployment.yaml