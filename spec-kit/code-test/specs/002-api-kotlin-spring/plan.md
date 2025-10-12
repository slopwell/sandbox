# Implementation Plan: 書籍管理システムのバックエンドAPI

**Branch**: `002-api-kotlin-spring` | **Date**: 2025-09-06 | **Spec**: /specs/002-api-kotlin-spring/spec.md
**Input**: Feature specification from `/specs/002-api-kotlin-spring/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
4. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
5. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file
6. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
7. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
8. STOP - Ready for /tasks command
```

## Summary
書籍・著者の登録・更新、著者に紐づく本の取得APIをKotlin/Spring Boot/jOOQで実装する。RDBを利用し、仕様・要件はspec.mdおよびmemo.mdに準拠。

## Technical Context
**Language/Version**: Kotlin (JVM), Java 17/21
**Primary Dependencies**: Spring Boot, jOOQ, Flyway, PostgreSQL
**Storage**: PostgreSQL
**Testing**: JUnit, Spring Test, jOOQテスト
**Target Platform**: Linux server
**Project Type**: backend (API)
**Performance Goals**: NEEDS CLARIFICATION
**Constraints**: 書籍価格0以上、著者1人以上、出版済み→未出版不可、生年月日過去日付
**Scale/Scope**: NEEDS CLARIFICATION

## Constitution Check
**Simplicity**:
- Projects: 1 (backend)
- Using framework directly? Yes (Spring Boot, jOOQ)
- Single data model? Yes
- Avoiding patterns? Repository等は不要

**Architecture**:
- EVERY feature as library? N/A（API単体）
- Libraries listed: N/A
- CLI per library: N/A
- Library docs: N/A

**Testing (NON-NEGOTIABLE)**:
- RED-GREEN-Refactor cycle enforced? Yes
- Git commits show tests before implementation? Yes
- Order: Contract→Integration→E2E→Unit
- Real dependencies used? Yes（実DB）
- Integration tests for: contract, shared schema
- FORBIDDEN: Implementation before test, skipping RED phase

**Observability**:
- Structured logging included? Yes
- Frontend logs → backend? N/A
- Error context sufficient? Yes

**Versioning**:
- Version number assigned? Yes
- BUILD increments on every change? Yes
- Breaking changes handled? Yes

## Project Structure

### Documentation (this feature)
specs/002-api-kotlin-spring/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)

### Source Code (repository root)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

**Structure Decision**: backend（APIのみ、Option 1ベースでbackend/配下に実装）

## Phase 0: Outline & Research
- NEEDS CLARIFICATION:
  - ユーザー認証や権限管理は必要か？
  - エラーメッセージやレスポンス形式の詳細仕様は？
  - パフォーマンス目標、スケール要件
- Technology best practices:
  - Kotlin/Spring Boot/jOOQ/Flyway/PostgreSQLのAPI設計・テスト手法

## Phase 1: Design & Contracts
- data-model.md: 書籍・著者エンティティ、バリデーション、リレーション
- contracts/: REST APIエンドポイント設計（OpenAPI形式）
- quickstart.md: API利用例、テストシナリオ

## Phase 2: Task Planning Approach
- /tasksコマンドでtasks.mdを生成（TDD順、依存順、並列化）

## Complexity Tracking
| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|

## Progress Tracking
**Phase Status**:
- [ ] Phase 0: Research complete (/plan command)
- [ ] Phase 1: Design complete (/plan command)
- [ ] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [ ] Initial Constitution Check: PASS
- [ ] Post-Design Constitution Check: PASS
- [ ] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
