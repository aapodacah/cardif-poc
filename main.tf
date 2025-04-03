terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.0"
    }
  }
}

provider "ibm" {
  region = "br-sao"
}

resource "ibm_resource_group" "resource_group" {
  name = "apodaca-poc-resource-group"
}

resource "ibm_container_registry" "registry" {
  name          = "apodaca-poc-registry"
  resource_group_id = ibm_resource_group.resource_group.id
}

resource "ibm_code_engine_project" "project" {
  name              = "apodaca-poc-project"
  resource_group_id = ibm_resource_group.resource_group.id
} 