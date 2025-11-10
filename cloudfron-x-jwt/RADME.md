# CloudFront-X-JWT

API-GW では 10MB までのペイロード制限があり、大容量ファイルをフロントエンドで DL できない問題がある。
CloudFront-X-JWT は、CloudFront の Lambda@Edge を利用して、JWT 認証を行い、大容量ファイルを配信できる構成にする

## 構成

- S3 バケット（大容量ファイル格納用）
- CloudFront ディストリビューション
- Lambda@Edge（JWT 認証用）
- API Gateway（JWT 発行用）
- Cognito User Pool（ユーザ管理用）
- Lambda（ダミーの API エンドポイント）
- ※IAM ロールは適当に...

リージョン：`ap-northeast-1`

## フォルダ説明

- terraform: AWS インフラ
- lambda: Lambda のソースコード
