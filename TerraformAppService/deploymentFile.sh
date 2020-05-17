#!/bin/bash
cd ../HelloWorldDotNetCore
az login --service-principal -u APP_URL -p ARM_CLIENT_SECRET --tenant ARM_TENANT_ID
#the following line migth be redundant
az webapp deployment user set --user-name GIT_USER_NAME --password GIT_PASSWORD
url=`az webapp deployment list-publishing-credentials --name "terraform-appservice-kmusiuk" --resource-group "terraform-test-group" --query scmUri --output tsv`
git remote add azure $url
git config credential.helper store --file=".git-credentials"
## modify created file 
## add git credentials email, user
git config --global user.name "terraformUser"
git config --global user.email terraformUser@example.com
echo $url > .git-credentials
git push azure master

