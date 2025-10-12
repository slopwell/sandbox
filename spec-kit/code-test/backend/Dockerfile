# 利用ツール: Spring initializr️（https://start.spring.io/）
# Project:Gradle - Groovy
# 言語選択: Kotlin
# 追加プラグイン: JOOQ Access Layer, Flyway Migration, PostgreSQL Driver, Docker Compose Support

FROM amazoncorretto:17-alpine-jdk

# 作業ディレクトリの作成
WORKDIR /app

# Gradle Wrapperをダウンロード・セットアップ
RUN wget https://services.gradle.org/distributions/gradle-8.5-bin.zip -O /tmp/gradle.zip \
	&& unzip /tmp/gradle.zip -d /opt \
	&& ln -s /opt/gradle-8.5/bin/gradle /usr/bin/gradle

# ホストのプロジェクトファイルをコンテナにコピー
COPY . .



# Gradleのビルドキャッシュを利用するための設定（wrapperを使わず直接gradleコマンドを利用）
# ビルド時に外部サービス依存のテストを実行すると失敗するため、テストをスキップしてjarを作成する
RUN gradle bootJar -x test --no-daemon

# ポートの公開
EXPOSE 8080

# コンテナ起動時に実行されるコマンド
ENTRYPOINT ["sh", "-c", "java -jar build/libs/book-management-backend-0.0.1-SNAPSHOT.jar"]
