# research.md

## Unresolved Questions (NEEDS CLARIFICATION)
- ユーザー認証や権限管理は必要か？
- エラーメッセージやレスポンス形式の詳細仕様は？
- パフォーマンス目標、スケール要件は？

## Technology Best Practices
- Kotlin/Spring Boot/jOOQ/Flyway/PostgreSQLのAPI設計・テスト手法
  - RESTful設計、OpenAPIによるスキーマ定義
  - jOOQによる型安全なDBアクセス
  - FlywayによるDBマイグレーション管理
  - JUnit/Spring Testによるテスト駆動開発

## Decision & Rationale
- 言語・フレームワーク: Kotlin + Spring Boot + jOOQ + Flyway + PostgreSQL
  - 理由: 型安全・生産性・拡張性・テスト容易性
- DB設計: 書籍・著者の多対多リレーション、バリデーションはアプリ層で担保
- テスト: RED-GREEN-Refactorサイクル厳守、実DBでの統合テスト重視

## Alternatives Considered
- ORM: jOOQ以外（JPA/Hibernate等）は要件に対し冗長・複雑化の懸念あり
- DB: MySQL等も候補だが、PostgreSQLの型・拡張性を優先

---
*NEEDS CLARIFICATIONが残る場合は、要件定義者に確認が必要です。*
