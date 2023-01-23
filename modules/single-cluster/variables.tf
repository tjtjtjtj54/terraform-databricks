variable "cluster_name" {
  type = string
}

variable "cluster_autotermination_minutes" {
  type    = number
  default = 10
}

data "databricks_node_type" "smallest" {
  local_disk = true
}

variable "databricks_node_type_id" {
  type    = string
  default = null
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

variable "databricks_spark_version_id" {
  type    = string
  default = null
}

variable "cluster_pypi_libraries" {
  type    = list(string)
  default = null
}

variable "cluster_maven_libraries" {
  type = list(object({
    coordinates = string
    exclusions  = optional(list(string))
  }))
  default = null
}

variable "cluster_jar_libraries" {
  type    = list(string)
  default = null
}

variable "cluster_egg_libraries" {
  type    = list(string)
  default = null
}

variable "cluster_whl_libraries" {
  type    = list(string)
  default = null
}

variable "init_scripts" {
  type    = list(string)
  default = null
}
