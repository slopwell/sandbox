# TEMPLATE-CICD

## 概要

CodeCommit x CodeBuild x TerraGrunt x Lambda(Node.js) で構成する CI/CD テンプレート

## Terragrunt

### インストール

```bash

curl -Ls -o terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.48.0/terragrunt_linux_amd64

sudo mv terragrunt /usr/local/bin/terragrunt

sudo chown root:root /usr/local/bin/terragrunt

sudo chmod 555 /usr/local/bin/terragrunt

terragrunt --version
```

### コマンド

ファイル生成 `terragrunt generate`
他は terraform と同じ

- `terragrunt init`
- `terragrunt plan`
- `terragrunt apply`
- `terragrunt destroy`

## CodeBuild

### buildspec.yml

このファイルをもとに CodeBuild がビルドを実行する
