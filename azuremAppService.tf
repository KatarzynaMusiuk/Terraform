
# Configure the Azure Provider
provider "azurerm" {
  
  version = "=2.0.0"
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
  name     = "terraform-test-group"
  location = "Central US"
}



resource "azurerm_app_service_plan" "servicePlan" {
  name                = "terraformServicePlan"
  location            = azurerm_resource_group.testGroup.location
  resource_group_name = azurerm_resource_group.testGroup.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "appService" {
  name                = "terraform-appservice-kmusiuk"
  location            = azurerm_resource_group.testGroup.location
  resource_group_name = azurerm_resource_group.testGroup.name
  app_service_plan_id = azurerm_app_service_plan.servicePlan.id

}
