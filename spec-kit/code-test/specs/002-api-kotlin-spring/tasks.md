# Tasks: 書籍管理システムのバックエンドAPI

**Input**: Design documents from `/specs/002-api-kotlin-spring/`
**Prerequisites**: plan.md (required), research.md, data-model.md, contracts/

## Phase 3.1: Setup
- [ ] T001 プロジェクト構成（backend/src/models, services, api, tests）を作成
- [ ] T002 Kotlin/Spring Boot/jOOQ/Flyway/PostgreSQL依存をGradleで初期化
- [ ] T003 [P] Lint/formatツール（ktlint等）を設定

## Phase 3.2: Tests First (TDD)
- [ ] T004 [P] Contract test POST /books in backend/tests/contract/BookApiContractTest.kt
- [ ] T005 [P] Contract test PUT /books in backend/tests/contract/BookApiContractTest.kt
- [ ] T006 [P] Contract test POST /authors in backend/tests/contract/AuthorApiContractTest.kt
- [ ] T007 [P] Contract test PUT /authors in backend/tests/contract/AuthorApiContractTest.kt
- [ ] T008 [P] Contract test GET /authors/{authorId}/books in backend/tests/contract/AuthorBooksApiContractTest.kt
- [ ] T009 [P] Integration test: 書籍・著者登録・更新・取得 in backend/tests/integration/BookAuthorIntegrationTest.kt

## Phase 3.3: Core Implementation
- [ ] T010 [P] Bookモデルを backend/src/models/Book.kt に実装
- [ ] T011 [P] Authorモデルを backend/src/models/Author.kt に実装
- [ ] T012 BookService/AuthorServiceを backend/src/services/ に実装
- [ ] T013 Book/Author APIエンドポイントを backend/src/api/BookApi.kt, AuthorApi.kt に実装
- [ ] T014 バリデーション（価格>=0, 著者1人以上, 生年月日過去, 出版済み→未出版不可）を実装

## Phase 3.4: Integration
- [ ] T015 DB接続・jOOQ/Flyway設定を backend/src/ 配下に実装
- [ ] T016 ロギング・エラーハンドリングを backend/src/ に実装

## Phase 3.5: Polish
- [ ] T017 [P] バリデーション/ユニットテストを backend/tests/unit/ValidationTest.kt に追加
- [ ] T018 [P] パフォーマンステスト/負荷テストを backend/tests/perf/PerfTest.kt に追加
- [ ] T019 [P] ドキュメント（OpenAPI, quickstart.md, README）を更新

## Dependencies
- T004-T009（テスト）→ T010以降（実装）
- モデル（T010, T011）→ サービス（T012）→ API（T013）
- バリデーション（T014）はモデル・API両方に依存
- DB/ロギング（T015, T016）はサービス・APIに依存
- Polish（T017-T019）は全実装後

## Parallel Example
```
# Launch contract/integration tests together:
Task: "Contract test POST /books in backend/tests/contract/BookApiContractTest.kt"
Task: "Contract test PUT /books in backend/tests/contract/BookApiContractTest.kt"
Task: "Contract test POST /authors in backend/tests/contract/AuthorApiContractTest.kt"
Task: "Contract test PUT /authors in backend/tests/contract/AuthorApiContractTest.kt"
Task: "Contract test GET /authors/{authorId}/books in backend/tests/contract/AuthorBooksApiContractTest.kt"
Task: "Integration test: 書籍・著者登録・更新・取得 in backend/tests/integration/BookAuthorIntegrationTest.kt"
```

## Validation Checklist
- [x] All contracts have corresponding tests
- [x] All entities have model tasks
- [x] All tests come before implementation
- [x] Parallel tasks truly independent
- [x] Each task specifies exact file path
- [x] No task modifies same file as another [P] task
