terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "app_name" {
  description = "Base name for all resources"
  type        = string
  default     = "cardif-poc"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.app_name}-RG"
  location = "southcentralus"
}

resource "azurerm_container_registry" "acr" {
  name                = replace("${var.app_name}acr", "-", "")
  resource_group_name = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  sku                = "Basic"
  admin_enabled      = true
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.app_name}-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  os_type            = "Linux"
  sku_name           = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_name}-app"
  resource_group_name = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  service_plan_id    = azurerm_service_plan.app_service_plan.id

  site_config {
    application_stack {
      docker_image     = "${azurerm_container_registry.acr.login_server}/${var.app_name}"
      docker_image_tag = "latest"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}