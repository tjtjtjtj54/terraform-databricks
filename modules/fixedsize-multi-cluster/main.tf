resource "databricks_cluster" "fixedsize_multi_node" {
  cluster_name            = var.cluster_name
  data_security_mode      = "SINGLE_USER"
  spark_version           = coalesce(var.databricks_spark_version_id, data.databricks_spark_version.latest_lts.id)
  node_type_id            = coalesce(var.databricks_node_type_id, data.databricks_node_type.smallest.id)
  autotermination_minutes = var.cluster_autotermination_minutes

  num_workers = var.num_workers

  custom_tags = {
    "ResourceClass" = "MultiNode"
  }

  dynamic "library" {
    for_each = toset(var.cluster_pypi_libraries) != null ? toset(var.cluster_pypi_libraries) : []
    content {
      pypi {
        package = library.value
      }
    }
  }

  dynamic "library" {
    for_each = toset(var.cluster_maven_libraries) != null ? toset(var.cluster_maven_libraries) : []
    content {
      maven {
        coordinates = library.value.coordinates
        exclusions  = library.value.exclusions
      }
    }
  }

  dynamic "library" {
    for_each = toset(var.cluster_jar_libraries) != null ? toset(var.cluster_jar_libraries) : []
    content {
      jar = library.value
    }
  }

  dynamic "library" {
    for_each = toset(var.cluster_egg_libraries) != null ? toset(var.cluster_egg_libraries) : []
    content {
      egg = library.value
    }
  }

  dynamic "library" {
    for_each = toset(var.cluster_whl_libraries) != null ? toset(var.cluster_whl_libraries) : []
    content {
      whl = library.value
    }
  }

  dynamic "init_scripts" {
    for_each = toset(var.init_scripts) != null ? toset(var.init_scripts) : []
    content {
      dbfs {
        destination = init_scripts.value
      }
    }
  }

}

output "cluster_url" {
  value = databricks_cluster.fixedsize_multi_node.url
}
