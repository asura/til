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

## 1. 問題点

* [PlantUML拡張](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml) のv2.11.3から仕様変更あり
  * Markdown中のPlantUMLをプレビュー表示させるには、サーバURLの指定が必要

## 2. 解決策

### 2.1. 案1

* VS Codeにて公式サーバを参照するよう設定する

#### 2.1.1. 具体例

* VS Codeの `setting.json` にて以下を定義
```json
  "plantuml.server": "https://www.plantuml.com/plantuml",
  "plantuml.render": "PlantUMLServer"
```

### 2.2. 案2

* PlantUMLサーバをDockerコンテナとして起動させる
* VS Codeから上記サーバを参照するよう設定する

#### 2.2.1. 具体例

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

## A. 参考サイト

* [UMLの爆速プレビュー環境をVisual Studio Code + PlantUML Server on Dockerで簡単に構築する ｜ DevelopersIO](https://dev.classmethod.jp/tool/plantuml-server-on-docker/#toc-plantuml-serverdocker)
* [plantuml/plantuml-server: PlantUML Online Server](https://github.com/plantuml/plantuml-server)