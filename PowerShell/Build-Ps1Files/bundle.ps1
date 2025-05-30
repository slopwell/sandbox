# Main.ps1

# モジュールをインポートする
Import-Module ./modules/Module.psm1


# ここにスクリプトのコードを記述する
if (-not (Test-Path ./dist/bundle)) {
    New-Item ./dist/bundle -Force -Type Directory
}

# すべてのスクリプトを結合して、OUT.ps1ファイルに出力する
(Get-Content ./Main.ps1 | Select-String -Pattern 'Import-Module' -NotMatch) | Out-File ./dist/bundle/OUT.ps1 -Encoding utf8
Get-Content ./modules/Module.psm1 | Out-File ./dist/bundle/OUT.ps1 -Encoding utf8 -Append-