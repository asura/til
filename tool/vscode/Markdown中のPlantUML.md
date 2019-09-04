# Markdown中のPlantUML

```plantuml
skinparam {
  monochrome true
  shadowing false
}
hide circle
hide empty members

class Foo {
  + foo()
}
```

## 問題点

* [PlantUML拡張](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml) のv2.11.3から仕様変更あり
  * Markdown中のPlantUMLをプレビュー表示させるには、サーバURLの指定が必要

## 解決策

* PlantUMLサーバをDockerコンテナとして起動させる
* VS Codeから上記サーバを参照するよう設定する

### 具体例

* `docker-compose.yml` に以下を追記

```yaml
plantuml-server:
  image: plantuml/plantuml-server:jetty
  container_name: plantuml-server
  ports:
    - 8080:8080
```

* `docker-compose up -d` とすると、サーバが起動する
* VS Codeの `setting.json` にて以下を定義
```json
  "plantuml.server": "http://localhost:8080",
  "plantuml.render": "PlantUMLServer"
```
