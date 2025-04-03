terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.0"
    }
  }
}

provider "ibm" {
  region = "br-sao"  # Puedes cambiar esto según tu región preferida
}

variable "app_name" {
  description = "Base name for all resources"
  type        = string
  default     = "cardif-poc"
}

variable "resource_group" {
  description = "IBM Cloud Resource Group name"
  type        = string
  default     = "cardif-poc-rg"
}

variable "container_namespace" {
  description = "IBM Cloud Container Registry namespace"
  type        = string
  default     = "cardif-poc-namespace"
}

# Resource Group (referencia al existente)
data "ibm_resource_group" "group" {
  name = var.resource_group
}

# Container Registry namespace
resource "ibm_container_namespace" "namespace" {
  name              = var.container_namespace
  resource_group_id = data.ibm_resource_group.group.id
}

# Code Engine Project
resource "ibm_code_engine_project" "project" {
  name              = "${var.app_name}-project"
  resource_group_id = data.ibm_resource_group.group.id
}

# Code Engine App
resource "ibm_code_engine_app" "app" {
  project_id      = ibm_code_engine_project.project.id
  name            = "${var.app_name}-app"
  image_reference = "br.icr.io/${var.container_namespace}/${var.app_name}:latest"
  image_port      = 8080
  image_secret    = "registry-secret"  # Debes crear este secret manualmente en Code Engine

  run_env_variables {
    type  = "literal"
    name  = "PORT"
    value = "8080"
  }

  run_scale {
    min_scale = 1
    max_scale = 1
  }
}

output "container_registry_namespace" {
  value = var.container_namespace
}

output "code_engine_project_name" {
  value = ibm_code_engine_project.project.name
}

output "code_engine_app_name" {
  value = ibm_code_engine_app.app.name
}

output "resource_group_name" {
  value = var.resource_group
}