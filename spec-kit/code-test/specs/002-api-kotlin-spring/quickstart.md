# quickstart.md

## API利用例

### 書籍の新規登録
```
POST /books
{
  "title": "サンプル書籍",
  "price": 1200,
  "authors": [1, 2],
  "status": "未出版"
}
```

### 書籍の更新
```
PUT /books
{
  "title": "サンプル書籍（改訂版）",
  "price": 1500,
  "authors": [1, 2],
  "status": "出版済み"
}
```

### 著者の新規登録
```
POST /authors
{
  "name": "山田 太郎",
  "birthdate": "1980-01-01"
}
```

### 著者の更新
```
PUT /authors
{
  "name": "山田 太郎",
  "birthdate": "1980-01-01"
}
```

### 著者に紐づく書籍一覧取得
```
GET /authors/1/books
レスポンス例:
[
  {
    "id": 10,
    "title": "サンプル書籍",
    "price": 1200,
    "status": "出版済み",
    "authors": [
      { "id": 1, "name": "山田 太郎", "birthdate": "1980-01-01" }
    ]
  }
]
```

---
*API仕様・利用例はOpenAPIスキーマと合わせて参照してください。*
