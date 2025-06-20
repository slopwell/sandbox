# basic-auth

Nginx x Express x React のアーキテクチャ

## 概要

- Exressでauthエンドポイント作成し、Basic認証を実装
- Nginxで認証可否を確認する
  - Expressで認証に成功(=200)していたらfrontend.htmlを返す
  - Expressで認証に失敗していたら401を返す
