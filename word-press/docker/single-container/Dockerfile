# WordPress + MySQL + phpMyAdmin + MongoDB + NodeJS + NginX
# WordPressコンテナをベースにして、すべてのサービスを1コンテナに統合するパターン
# このDockerfileは、追加でMySQL、phpMyAdmin、MongoDB、NodeJS、NginXをインストールする

# cat /etc/debian_version -> 12.7

# yum でパッケージをインストールする
FROM wordpress:latest

SHELL ["/bin/bash", "-c"]

# パッケージ更新
RUN apt-get update

# NodeJS (Volta)
# ---------------------------------------------------
  # Node ver の指定
  RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME=/root/.volta
ENV PATH=$VOLTA_HOME/bin:$PATH
RUN volta install node@22

# NginX
# ---------------------------------------------------
RUN apt-get update && apt-get install -y nginx
  
# phpMyAdmin
# ---------------------------------------------------
RUN apt-get update && apt-get install -y wget unzip
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O /tmp/phpmyadmin.zip
RUN unzip /tmp/phpmyadmin.zip -d /usr/share/
RUN mv /usr/share/phpMyAdmin-* /usr/share/phpmyadmin
RUN ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
RUN chown -R www-data:www-data /usr/share/phpmyadmin


# MongoDB Community
# ---------------------------------------------------
RUN apt-get update && apt-get install -y gnupg curl
# MongoDB 公開 GPG キーがないとapt-get installでエラーが発生する
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
RUN apt-get update && apt-get install -y mongodb-org

# MySQL
# ---------------------------------------------------
# `mysql-server` がリポジトリに存在しないため、`default-mysql-server` をインストール
RUN apt-get update && apt-get install -y default-mysql-server

# 気が向いたら調べる
# ---------------------------------------------------
  
# phpMyAdmin でapi keystring 使ってたが非推奨じゃなかったっけ？

# $ cat /etc/apt/sources.list.d/debian.sources
# ---
# Types: deb
# # http://snapshot.debian.org/archive/debian/20240926T000000Z
# URIs: http://deb.debian.org/debian
# Suites: bookworm bookworm-updates
# Components: main
# Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
# 
# Types: deb
# # http://snapshot.debian.org/archive/debian-security/20240926T000000Z
# URIs: http://deb.debian.org/debian-security
# Suites: bookworm-security
# Components: main
# Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

