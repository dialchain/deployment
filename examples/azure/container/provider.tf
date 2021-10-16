terraform {
  required_version = "~> 1.0.0"

  backend "azurerm" {
    resource_group_name  = "infra-resources"
    storage_account_name = "monwallet"
    container_name       = "monwallet-tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
