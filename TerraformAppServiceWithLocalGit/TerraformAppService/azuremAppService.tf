#variables

variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "service_plan_name" {
  type = string
}
variable "app_service_name" {
  type = string
}



# Configure the Azure Provider
provider "azurerm" {
  
  version = "=2.7.0"
  features {}
}


# Configure state file
terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-northeurope"      
    storage_account_name = "storagetest1account"     
    container_name       = "testblobcontainer"  
    key                  = "terraformStateFileName.tfstate"
  }
}


# Create  resources:

resource "azurerm_resource_group" "testGroup" {
  name     = var.resource_group_name
  location = var.resource_group_location
}



resource "azurerm_app_service_plan" "servicePlan" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.testGroup.location
  resource_group_name = azurerm_resource_group.testGroup.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appService" {
  name                = var.app_service_name
  location            = azurerm_resource_group.testGroup.location
  resource_group_name = azurerm_resource_group.testGroup.name
  app_service_plan_id = azurerm_app_service_plan.servicePlan.id
  
    site_config {
    scm_type = "LocalGit"
  }
  
  provisioner "local-exec" {
    command = "bash deploymentFile.sh"
  }
}
