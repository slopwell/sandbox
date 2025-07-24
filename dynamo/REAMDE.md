これをやっていく

https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/programming-with-javascript.html

# 環境構築

## DynamoDB Local

compose.yaml を作成し、`docker compose up -d` で起動する
- chmod と chown しておかないと、AWS CLI 実行時に応答が無くなる

```sh
docker compose down -v

USER=$(whoami)
GROUP=$(id -g $USER)
mkdir -p docker/dynamodb
sudo chown $USER:$GROUP docker/dynamodb
sudo chmod 777 docker/dynamodb

docker compose up -d
```

```yaml:compose.yaml
services:
 dynamodb-local:
   command: "-jar DynamoDBLocal.jar -sharedDb -dbPath ./data"
   image: "amazon/dynamodb-local:latest"
   container_name: dynamodb-local
   ports:
     - "8000:8000"
   volumes:
     - "./docker/dynamodb:/home/dynamodblocal/data"
   working_dir: /home/dynamodblocal
```


## AWS CLI
https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html

```sh:aws-cli
which aws
aws --version

# dynamodb local用のダミープロファイル作成
aws configure --profile dynamodb-local
# > AWS Access Key ID [None]: DUMMYACCESSKEYID
# > AWS Secret Access Key [None]: DUMMYSECRETACCESSKEY
# > Default region name [None]: us-west-2
# > Default output format [None]: json
```

## Table 作成

DynamoDB ではキーはハッシュとレンジだけ

- ハッシュキー: 一意に識別するためのキー。パーティションキー
- レンジキー: ハッシュキーの値が同じ場合に、さらに識別するためのキー。ソートキー

| カラム名  | 型     | 説明           | キー種類 |
| --------- | ------ | -------------- | -------- |
| Artist    | String | アーティスト名 | HASH     |
| SongTitle | String | 曲名           | RANGE    |

```sh:create-table
aws dynamodb create-table \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
    --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
    --billing-mode PAY_PER_REQUEST \
    --table-class STANDARD
```

```sh:テーブルの確認
aws dynamodb list-tables --profile dynamodb-local --endpoint-url http://localhost:8000

aws dynamodb describe-table \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music
```

## データ投入

| Artist (hash)   | SongTitle (sort) | AlbumTitle          | Awards |
| --------------- | ---------------- | ------------------- | ------ |
| No One You Know | Call Me Today    | Somewhat Famous     | 1      |
| No One You Know | Howdy            | Somewhat Famous     | 2      |
| Acme Band       | Happy Day        | Songs About Life    | 10     |
| Acme Band       | PartiQL Rocks    | Another Album Title | 8      |

```sh:put-item
aws dynamodb put-item \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music  \
    --item \
        '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Awards": {"N": "1"}}'

aws dynamodb put-item \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music  \
    --item \
        '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Howdy"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Awards": {"N": "2"}}'

aws dynamodb put-item \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --item \
        '{"Artist": {"S": "Acme Band"}, "SongTitle": {"S": "Happy Day"}, "AlbumTitle": {"S": "Songs About Life"}, "Awards": {"N": "10"}}'

aws dynamodb put-item \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --item \
        '{"Artist": {"S": "Acme Band"}, "SongTitle": {"S": "PartiQL Rocks"}, "AlbumTitle": {"S": "Another Album Title"}, "Awards": {"N": "8"}}'
```

## データ閲覧

```sh
# データ全件
aws dynamodb scan \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music

# 特定のハッシュキーのデータ取得
aws dynamodb query \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --key-condition-expression "Artist = :artist" \
    --expression-attribute-values  '{":artist":{"S":"No One You Know"}}'

# 特定のハッシュキーとソートキーのデータ取得
aws dynamodb get-item \
    --profile dynamodb-local \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --key \
        '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}}'
```

# JS SDKでのクライアント実装

AWS SDK JSV3 では、AWS APIを実行する際に基本的には以下の流れで処理することになる
- 各サービスごとのクライアントの定義
- 各APIごとのコマンドを定義
- クライアントを使ってコマンドを実行

## DynamoDB クライアントの作成

JSSDK DynamoDB クライアントには、 DocumentClient と DB クライアントの2種類がある
- DocClient: 高レベルAPI。JavaScriptのオブジェクトをそのまま扱える
- DBクライアント: 低レベルAPI。DynamoDBのデータ型をそのまま扱う
- 使いやすさファーストで、DocClientを使う

```js:client.js
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient } from "@aws-sdk/lib-dynamodb";

// dynamo local用の設定
const config = {
  region: "ap-northeast-1",
  endpoint: "http://localhost:8000",
  credentials: {
    accessKeyId: "dummy",
    secretAccessKey: "dummy",
  },
};

const client = new DynamoDBClient(config);
const docClient = DynamoDBDocumentClient.from(client);

export { docClient };

```

## 検索処理

以下のSQL相当の検索処理を実装する

```sql
SELECT * 
FROM Music 
WHERE Artist = 'No One You Know'
;
```

DynamoDB では、`QueryCommand`を使って検索を行う
- `KeyConditionExpression`: 検索条件を指定する
- `ExpressionAttributeValues`: 検索条件の値を指定する。
  - KeyConditionExpression で指定する値は、`:artist`のようにプレースホルダを使う

SQLでいうところの WHERE 無しの検索は、 Scan で実施できるが個人的には非推奨
- Scanは取得上限があるため、分割されたページを取得後に結合しなければならない

```js:main.js
import { docClient } from "./client.js";
import { QueryCommand } from "@aws-sdk/lib-dynamodb";

console.log("QueryCommand: 検索条件を指定してデータを取得");
const queryCommand  = new QueryCommand({
    TableName: "Music",
    KeyConditionExpression: "Artist = :artist",
    ExpressionAttributeValues: {
        ":artist": artist,
    },
    ConsistentRead: true,
});
const queryResult = await sendDocClientCommand(queryCommand);
console.log("QueryCommand Count: %s Result: %o", queryResult.length, queryResult);
```

## 検索処理 (特定のデータ)

以下のSQL相当の検索処理を実装する

```sql
SELECT TOP 1 *
FROM Music
WHERE Artist = 'No One You Know' AND SongTitle = 'Call Me Today'
;
```

DynamoDB では、`GetCommand`を使って主キーを指定してデータを取得する
- 主キーはハッシュキーとソートキーの組み合わせで指定する
- QueryCommandと違い、GetCommandは単一のアイテムを取得するため、KeyConditionExpressionは不要

```js:main.js
import { docClient } from "./client.js";
import { GetCommand } from "@aws-sdk/lib-dynamodb";

console.log("GetCommand: 主キーを指定してデータを取得");

const getCommand = new GetCommand({
    TableName: "Music",
    Key: {
        Artist: "No One You Know",
        SongTitle: "Call Me Today",
    },
    });
const getResult = await sendDocClientCommand(getCommand);
console.log("GetCommand Result:", getResult);
```

## データ登録

以下のSQL相当のデータ登録処理を実装する

```sql
INSERT INTO Music (Artist, SongTitle, AlbumTitle, Awards)
VALUES ('No One You Know', 'New Song', 'New Album', 5)
;
```

DynamoDB では、`PutItemCommand`を使ってデータを登録する
- `Item`: 登録するデータを指定する
- 指定した主キーが存在しない場合は新規登録、存在する場合は上書き登録を行う


```js:main.js
import { docClient } from "./client.js";
import { PutCommand } from "@aws-sdk/lib-dynamodb";

console.log("PutCommand: データを登録");
const putCommand = new PutCommand({
    TableName: "Music",
    Item: {
        Artist: "No One You Know",
        SongTitle: "New Song",
        AlbumTitle: "New Album",
        Awards: 5,
    },
});
const putResult = await sendDocClientCommand(putCommand);
console.log("PutCommand Result:", putResult);
```

## データ更新

以下のSQL相当のデータ更新処理を実装する

```sql
UPDATE Music
SET SongTitle = 'New Song', AlbumTitle = 'New Album', Awards = 5
WHERE Artist = 'No One You Know' AND SongTitle = 'Call Me Today'
;
```

DynamoDB では、`UpdateCommand`を使ってデータを更新する
- `Key`: 更新対象の主キーを指定する
- `UpdateExpression`: 更新内容を指定する
- `ExpressionAttributeValues`: 更新内容の値を指定する
- `ReturnValues`: 更新後のデータを取得するために、`ALL_NEW`を指定する

```js:main.js
import { docClient } from "./client.js";
import { UpdateCommand } from "@aws-sdk/lib-dynamodb";

console.log("UpdateCommand: データを更新");
const updateCommand = new UpdateCommand({
    TableName: "Music",
    Key: {
        Artist: "No One You Know",
        SongTitle: "Call Me Today",
    },
    UpdateExpression: "SET SongTitle = :newSongTitle, AlbumTitle = :newAlbumTitle, Awards = :newAwards",
    ExpressionAttributeValues: {
        ":newSongTitle": "New Song",
        ":newAlbumTitle": "New Album",
        ":newAwards": 5,
    },
    ReturnValues: "ALL_NEW",
});
const updateResult = await sendDocClientCommand(updateCommand);
console.log("UpdateCommand Result:", updateResult);
    
```


# まとめ

SQL vs NoSQL は、パフォーマンス、検索の複雑さ、データの堅牢さで決めるのが良いと思います。
- SQL: 検索の複雑さが高い場合や、データの整合性が重要な場合に適している
- NoSQL: パフォーマンスが重要な場合や、データの構造が柔軟な場合に適している
- DynamoDBは、スケーラビリティとパフォーマンスに優れたNoSQLデータベースであり、特に大規模なデータセットや高トラフィックのアプリケーションに適している
