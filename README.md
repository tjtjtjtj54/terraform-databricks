# terraform-databricks
本リポジトリは、databricksのクラスターをイミュータブルに管理するものである。
クラスターの全パラメータは網羅せず、必要と思われるものを指定可能にした。
## 環境
- terraform ~> 1.3.7
- databricks provider = "1.9.0"
## 手順
- environmentsから対象となるsampleディレクトリをコピー(コピー対象ファイルは下記のみ)
    - main.tf
    - provider.tf
- main.tfをカスタマイズ
- tfvarsで、databricksのURLを設定
    - databricks_host = "https://xxxxxxxxx/"
- az login
- az account list
    - 対象のアカウントが"isDefault": true、"state": "Enabled"になっていることを確認
- terraform init
- terraform plan
- terraform apply

## その他
- ローカルからの各自実行を想定し、backendは指定しない