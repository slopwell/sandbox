# 書籍管理システム バックエンドAPI

## 概要
Kotlin/Spring Boot/jOOQ/Flyway/PostgreSQL による書籍・著者管理API。

## セットアップ
- `docker-compose up -d` でDB起動
- `./gradlew build` でビルド
- `./gradlew test` でテスト

## 仕様・設計
- OpenAPI: ../specs/002-api-kotlin-spring/contracts/openapi.yaml
- Quickstart: ../specs/002-api-kotlin-spring/quickstart.md

## ディレクトリ構成
- src/models, src/services, src/api, tests/
