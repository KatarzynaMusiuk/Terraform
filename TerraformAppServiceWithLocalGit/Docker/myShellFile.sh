#!/bin/bash
git clone https://github.com/KatarzynaMusiuk/Terraform
cd Terraform/TerraformAppServiceWithLocalGit/TerraformAppService

# run the terraform file in the directory Terraform
terraform init
terraform plan -input=false -out myplan.out 
terraform show myplan.out 
terraform apply -auto-approve -input=false myplan.out 