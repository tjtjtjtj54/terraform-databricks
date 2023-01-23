variable "databricks_host" {
  description = "The Azure Databricks workspace URL."
  type        = string
}

terraform {
  required_version = "~> 1.3.7"
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "databricks" {
  host = var.databricks_host
}

data "databricks_current_user" "me" {}