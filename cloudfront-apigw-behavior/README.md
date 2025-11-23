# 概要

API-GW の前段に CloudFront を配置したときの Behavior 挙動検証

- API クライアント -> CloudFront -> API-GW -> Lambda
- API クライアント
  - `https://<CloudFrontのドメイン>/prod/hello` にアクセスする
  - cURL コマンドを使用し認証は無し
- API-GW
  - ステージは `prod` と `dev` を作成する
  - GET /hello リソースを作成する
- CloudFront
  - ビヘイビアのパスパターンは `/prod/*`
    - `/api/*` のは不可※
  - オリジンは API-GW の URL を指定する
  - オリジンパスは指定しない（空文字）
  - キャッシュポリシーは `CACHING_DISABLED` を指定する
  - フォワードヘッダーは `AllViewerExceptHostHeader` を指定する
- Lambda
  - 適当にログを出して、 Hello World + ステージ名を返す

## 不可の理由

> For example, suppose you've specified the following values for your distribution:
> Origin domain – An Amazon S3 bucket named amzn-s3-demo-bucket
> Origin path – /production
> Alternate domain names (CNAME) – example.com
> When a user enters example.com/index.html in a browser, CloudFront sends a request to Amazon S3 for amzn-s3-demo-bucket/> production/index.html.
>
> When a user enters example.com/acme/index.html in a browser, CloudFront sends a request to Amazon S3 for amzn-s3-demo-bucket/> production/acme/index.html.
> https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html
