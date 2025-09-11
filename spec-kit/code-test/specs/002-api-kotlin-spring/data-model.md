# data-model.md

## Entities

### Book（書籍）
- id: Long（主キー）
- title: String（必須）
- price: Int（0以上）
- status: String（未出版/出版済み）
- authors: List<Author>（1人以上、複数可）

#### Validation
- price >= 0
- authors.size >= 1
- status: "出版済み"→"未出版"への変更不可

### Author（著者）
- id: Long（主キー）
- name: String（必須）
- birthdate: LocalDate（現在より過去）
- books: List<Book>（複数可）

#### Validation
- birthdate < 現在

## Relationships
- Book:Author = 多対多

---
*バリデーション・リレーションはアプリ層で担保。*
