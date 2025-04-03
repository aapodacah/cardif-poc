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
resource "ibm_resource_group" "group" {
  name = var.resource_group
}

# Container Registry namespace
resource "ibm_cr_namespace" "namespace" {
  name              = var.container_namespace
  resource_group_id = ibm_resource_group.group.id
  depends_on        = [ibm_resource_group.group]
}

# Code Engine Project
resource "ibm_code_engine_project" "project" {
  name              = "${var.app_name}-project"
  resource_group_id = data.ibm_resource_group.group.id
  depends_on        = [ibm_cr_namespace.namespace]
}

output "container_registry_namespace" {
  value = var.container_namespace
}

output "code_engine_project_name" {
  value = ibm_code_engine_project.project.name
}

output "resource_group_name" {
  value = var.resource_group
}