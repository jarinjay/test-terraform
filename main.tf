terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform-rg" {
  name     = "terraform-testing"
  location = "West Europe"
}

## COMPLIANT RESOURCE ############################################################################

resource "azurerm_storage_account" "stgacc" {
  name                     = "stforgallery"
  resource_group_name      = azurerm_resource_group.terraform-rg.name
  location                 = azurerm_resource_group.terraform-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = false
  cross_tenant_replication_enabled = false


  tags = {
    environment = "staging"
    resource_type = "storage account"
  }
}

##################################################################################################

# terraform plan -out testSuccess.out
# terraform show -json testSuccess.out > testSuccess.out.json
# terraform-compliance -p testSuccess.out
# terraform-compliance -p testSuccess.out.json --features ./tests/.

##################################################################################################

## INCOMPLIANT RESOURCE ############################################################################


resource "azurerm_storage_account" "stgacc1" {
  name                     = "stgacc987"
  resource_group_name      = azurerm_resource_group.terraform-rg.name
  location                 = azurerm_resource_group.terraform-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = true
  cross_tenant_replication_enabled = false


  tags = {
    resource_type = "storage account"
  }
}

##################################################################################################

# terraform plan -out testingFail.out
# terraform show -json testingFail.out > testingFail.out.json
# terraform-compliance -p testingFail.out
# terraform-compliance -p testingFail.out.json --features ./tests/.

##################################################################################################
