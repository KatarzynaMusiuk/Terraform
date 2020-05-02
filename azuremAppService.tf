
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
  location = "West Europe"
}
