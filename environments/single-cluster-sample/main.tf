# 下記指定の場合、Standard_DS3_v2
data "databricks_node_type" "customization_type" {
  category            = "General Purpose"
  min_cores           = 4
  min_memory_gb       = 14
  local_disk_min_size = 28
}

module "single_cluster" {
  source       = "../../modules/single-cluster"
  cluster_name = "My terraform Cluster"

  # 以下は任意パラメータ
  # databricks_node_type_id(defaultはlocak disk trueの最小構成)
  databricks_node_type_id = data.databricks_node_type.customization_type.id

  # spark version id (defaultは最新のLTS)
  databricks_spark_version_id = "7.3.x-scala2.12"

  # 必要なライブラリ(pypi,maven,jar,egg,whlを指定(cranは未実装)
  cluster_pypi_libraries = ["azure-storage-blob", "pandas"]
  cluster_maven_libraries = [
    { coordinates = "com.amazon.deequ:deequ:1.0.4", exclusions = ["org.apache.avro:avro"] },
    { coordinates = "com.microsoft.sqlserver:mssql-jdbc:11.2.1.jre18" }
  ]
  cluster_jar_libraries = ["dbfs:/FileStore/app-0.0.1.jar"]
  cluster_egg_libraries = ["dbfs:/FileStore/foo.egg"]
  cluster_whl_libraries = ["dbfs:/FileStore/baz.whl"]

  init_scripts = ["dbfs:/init-scripts/install-elk.sh"]

}
