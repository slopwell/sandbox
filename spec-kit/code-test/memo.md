# 指示
書籍管理システムのバックエンドAPIの構築をお願いしています。
Web APIの作成のみをお願いしており、フロントエンドの実装は不要です。
可能な範囲で単体テストも作成をお願いします。

# 技術要件

言語: Kotlin
フレームワーク: Spring Boot、jOOQ


## 必要な機能

書籍と著者の情報をRDBに登録・更新できる機能
著者に紐づく本を取得できる機能


### 書籍の属性

タイトル
価格（0以上であること）
著者（最低1人の著者を持つ。複数の著者を持つことが可能）
出版状況（未出版、出版済み。出版済みステータスのものを未出版には変更できない）

### 著者の属性

名前
生年月日（現在の日付よりも過去であること）
著者も複数の書籍を執筆できる
補足


## 進め方の例

進め方の例を記載します。今回はSpring initializrや追加プラグインを利用していますが、こちらを利用しない形でも上記の技術スタック・仕様通り構築頂ければ問題ありません。

## 環境構築

業務上、新しいツールや技術の導入があり得るため、ドキュメントを参照しながら必要な環境構築が行えるかを確認します。
今回は例として、Spring initializrを使い以下の設定でプロジェクトを生成しました。今回は以下の追加プラグインを利用しましたが、プラグインの利用は必須ではありません。
- 利用ツール: Spring initializr️（https://start.spring.io/）
- Project:Gradle - Groovy
- 言語選択: Kotlin
- 追加プラグイン: JOOQ Access Layer, Flyway Migration, PostgreSQL Driver, Docker Compose Support
- Java :21 or 17
- SDKMANやasdf等を利用し、上記で指定したJDKをインストールします。
- Spring initializr️で生成したプロジェクトをIntelliJ IDEAにインポートし、JDK、Gradleの設定を行い開始します。

## 実装
必要なコントローラーやクラスを追加し、機能を実装していきます。
データベースの構築にはFlywayを使用し、その後jOOQでコードを自動生成して利用します。

jOOQでコードを自動生成する為に、以下を参照し設定を追加します。

> https://www.jooq.org/doc/3.19/manual/code-generation/codegen-gradle/
> https://www.jooq.org/doc/3.19/manual/code-generation/codegen-configuration/

## 評価の観点

評価は主に以下の観点で行います。

- 指定された技術スタックの適用
- フレームワークやライブラリの適切な利用
- 実行可能性
- 仕様に沿った動作
- 変数名やクラス名、関数名が実態を明確に反映しているか
- Null安全性
- コードフォーマットの整合性
- 変数に再代入しないなど、ベストプラクティスの遵守
- オーバーエンジニアリングしていないか
- 適切な単体テストが作成されているか

## 実行

起動
> sudo docker compose -f ./backend/compose.yaml build --no-cache
> sudo docker compose -f ./backend/compose.yaml up -d

テスト
> sudo docker compose -f ./backend/compose.yaml exec app gradle test --rerun-tasks --info

カバレッジレポートの取得
> cmd="cat /app/build/reports/tests/test/index.html"
> sudo docker compose -f ./backend/compose.yaml exec app sh -c "$cmd" > ./backend-test-report.html
