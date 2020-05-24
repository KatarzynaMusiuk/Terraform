#!/bin/bash
cd ../HelloWorldDotNetCore
#log in as terraform service principal
az login --service-principal -u $APP_URL -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
url=`az webapp deployment list-publishing-credentials --name "terraform-appservice-kmusiuk" --resource-group "terraform-test-group" --query scmUri --output tsv`
git remote add azure $url
#add git email and user
git config --global user.name "terraformUser"
git config --global user.email terraformUser@example.com
#store git credentials to authenticate automatically
git config credential.helper store --file=".git-credentials"
echo $url > .git-credentials
git push azure master

