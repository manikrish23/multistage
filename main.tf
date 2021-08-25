terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.39.0"
      
    }
  }
  provider "azurerm" {
  features {}
}

}
terraform {
    backend "azurerm" {
        resource_group_name  = "tfmainrg"
        storage_account_name = "tfstorageacc0001"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        access_key = "7pw826WFiP/JkJypbWkbuVfCyCWPcfCXaYVUCW96u20TWBhxSLaPbI2Uhpq+YskTryi9N12s+9IgZvVnzhkuRQ=="
    }
  }

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

# Configure the Microsoft Azure Provider
 
resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "Australia East"
}
resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "manikirish"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "manikrish/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}