
# Configure the Azure Provider
provider "azurerm" {
  
  version = "=2.0.0"
  features {}
}

# Configure state file
  backend "azurerm" {
    resource_group_name  = $groupName
    storage_account_name = $storageAccountName
    container_name       = $blobContainerName
    key                  = "terraformStateFileName.tfstate"
  }


# Create  resources:

resource "azurerm_resource_group" "testGroup" {
  name     = "terraformTestGroup"
  location = "West Europe"
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
  name                = "terraformAppService"
  location            = azurerm_resource_group.testGroup.location
  resource_group_name = azurerm_resource_group.testGroup.name
  app_service_plan_id = azurerm_app_service_plan.servicePlan.id

}
