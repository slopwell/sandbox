PowerShell の ps1, psm1 を 1 つのファイルにバンドルできるかを検証する

## 環境構築

WSL に PowerShell をインストールする

```bash
sudo apt-get update
sudo apt-get install -y wget apt-transport-https software-properties-common
source /etc/os-release
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell

# PowerShellを起動する
pwsh
```

## 結論

下記の観点で止めておくべき。おとなしく `electron`などで exe を作成したほうがいい

- ある程度はバンドルできるが、パス解決が困難
- Import/Export を削除するのが自前での判断になるため、汎用的ではない
- そもそもバンドルできたとしても、クライアントで書き換え可能になるため、セキュリティ的には問題がある
  - 難読化も自前になるため、汎用的ではない
