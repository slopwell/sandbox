# やりたかったこと

API-GW の前段に CloudFront を配置し、CloudFront のビヘイビアのパスパターンで API-GW のステージを制御しようとした

- API クライアント -> CloudFront -> API-GW -> Lambda
- API クライアント（cURL）
  - `https://<CloudFrontのドメイン>/api/hello` にアクセスする
- API-GW
  - ステージは `prod` と `dev` を作成する
  - `GET /hello` リソースを作成する
- CloudFront
  - ビヘイビアのパスパターンは `/api/*`
  - オリジンは API-GW の URL を指定する
  - オリジンパスは `/prod` を指定する
  - キャッシュポリシーは `CACHING_DISABLED` を指定する
  - フォワードヘッダーは `AllViewerExceptHostHeader` を指定する

# 結論

この枠の中で実現することは不可能
仮に実現したい場合は、下記の選択肢がありそう

- CloudFront Function でパスを書き換える
- API Gateway に `/api` リソースを追加
- API-GW カスタムドメイン + ベースパスマッピングを使用
- Cloudfront を使わずに API-GW のみで完結させる

## 実現不可の理由(公式ドキュメント)

オリジン（API Gateway など）内の特定のディレクトリから CloudFront にコンテンツをリクエストさせたい場合は、スラッシュ（/）で始まるディレクトリパスを入力してください。
CloudFront は、このディレクトリパスをオリジンドメインの値に付加します（例：cf-origin.example.com/production/images）。
パスの末尾にスラッシュ（/）は追加しないでください。
たとえば、ディストリビューションに以下の値を指定したとします。

- オリジンドメイン – amzn-s3-demo-bucket という名前の Amazon S3 バケット
- オリジンパス – /production
- 代替ドメイン名（CNAME） – example.com

ユーザーがブラウザで example.com/index.html と入力すると、CloudFront は Amazon S3 に対して amzn-s3-demo-bucket/production/index.html のリクエストを送信します。
ユーザーがブラウザで example.com/acme/index.html と入力すると、CloudFront は Amazon S3 に対して amzn-s3-demo-bucket/production/acme/index.html のリクエストを送信します。

> https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html

原文
Origin path

If you want CloudFront to request your content from a directory in your origin, enter the directory path, beginning with a slash (/).
CloudFront appends the directory path to the value of Origin domain, for example, cf-origin.example.com/production/images.
Do not add a slash (/) at the end of the path.

For example, suppose you’ve specified the following values for your distribution:

- Origin domain – An Amazon S3 bucket named amzn-s3-demo-bucket
- Origin path – /production
- Alternate domain names (CNAME) – example.com

When a user enters example.com/index.html in a browser, CloudFront sends a request to Amazon S3 for amzn-s3-demo-bucket/production/index.html.

When a user enters example.com/acme/index.html in a browser, CloudFront sends a request to Amazon S3 for amzn-s3-demo-bucket/production/acme/index.html.

# 検証時ログ

## 実行 Shell

```bash
API_GW_HOST="https://<api-gwドメイン>.execute-api.ap-northeast-1.amazonaws.com"
API_GW_DEV="$API_GW_HOST/dev/hello"
API_GW_PROD="$API_GW_HOST/prod/hello"
CLOUDFRONT_DOMAIN="https://<cloudfrontドメイン>.cloudfront.net"
CLOUDFRONT_API="$CLOUDFRONT_DOMAIN/api/hello"

echo "=== APIGW Dev"
curl -i $API_GW_DEV
echo ""
echo "=== APIGW Prod"
curl -i $API_GW_PROD
echo ""
echo "=== CloudFront"
curl -i $CLOUDFRONT_API
echo ""
```

## 実行結果

- API-GW の dev ステージへは正常にアクセス可能
- API-GW の prod ステージへは正常にアクセス可能
- CloudFront 経由でアクセスすると 403 Forbidden エラーとなる

```log
=== APIGW Dev
HTTP/2 200
content-type: application/json
content-length: 94
date: Thu, 20 Nov 2025 13:25:03 GMT
x-amzn-trace-id: Root=1-691f16af-1c2cb66e199c3a7201f228a5;Parent=3f4e0d2bd1589363;Sampled=0;Lineage=1:ead6d511:0
x-amzn-requestid: b0fb7fd4-3f8d-4d9d-874e-606da9dfb580
x-amz-apigw-id: UWB7bEd7tjMEASw=
x-cache: Miss from cloudfront
via: 1.1 f485912663487526227b85e90a0da778.cloudfront.net (CloudFront)
x-amz-cf-pop: NRT12-P8
x-amz-cf-id: WM_TYKjW_PUGCaihw4gmQtlZiIiyyu-6EulE-DPdob_APP7IlIk_FA==

{"message":"Hello World from stage: dev","stage":"dev","timestamp":"2025-11-20T13:25:03.520Z"}

=== APIGW Prod
HTTP/2 200
content-type: application/json
content-length: 96
date: Thu, 20 Nov 2025 13:25:03 GMT
x-amzn-trace-id: Root=1-691f16af-779b85f24d645fe1431be29e;Parent=26711222eba96d30;Sampled=0;Lineage=1:ead6d511:0
x-amzn-requestid: 024f994d-c2dd-4869-b1aa-e4a226df2be8
x-amz-apigw-id: UWB7gHzttjMEhGA=
x-cache: Miss from cloudfront
via: 1.1 eb025597eaaccb791918dc400048d224.cloudfront.net (CloudFront)
x-amz-cf-pop: NRT12-P8
x-amz-cf-id: ywKWU3YNS1n2nvySeY2FiMcIRslB-yRo2uLxin1SZO9ZzMbn3wphmQ==

{"message":"Hello World from stage: prod","stage":"prod","timestamp":"2025-11-20T13:25:03.693Z"}

=== CloudFront
HTTP/2 403
content-type: application/json
content-length: 23
x-amz-cf-pop: NRT12-P8
date: Thu, 20 Nov 2025 13:25:03 GMT
x-amz-apigw-id: UWB7jE4stjMEWeA=
x-amzn-requestid: c542973f-4d6e-4e29-bf15-dee501013801
x-amzn-errortype: ForbiddenException
via: 1.1 b6a7097997e2c9a80454aa70047f9342.cloudfront.net (CloudFront), 1.1 84116bff0a26d7866b2386043fce704c.cloudfront.net (CloudFront)
x-cache: Error from cloudfront
x-amz-cf-pop: NRT20-P3
x-amz-cf-id: hnTZm8BRPo2kttrhpFj6jnwfEuABzaJNo2mLPIujcVLOw-hIYsqkQQ==

{"message":"Forbidden"}
```
