# ゴミ箱内のファイルのプロパティを走査し、1か月以上前のファイルをゴミ箱から削除する
function Invoke-Main {
    $recycleBin = New-Object -ComObject Shell.Application
    $recycleBinFolder = $recycleBin.Namespace(0xa)
    $recycleBinFolder.Items() | ForEach-Object {
        $date = $_.ExtendedProperty("System.Recycle.DateDeleted")
        $date = [DateTime]::Parse($date)
        $span = New-TimeSpan -Start $date -End Get-Date
        if ($span.Days -gt 30) {
            $path = $_.Path
            $Name = $_.Name
            Write-Host "Delete: $path as '$Name'"
            # $item.InvokeVerb("Delete")
        }
    }
}


Invoke-Main
