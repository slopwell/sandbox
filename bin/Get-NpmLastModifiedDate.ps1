$path = "./package.json"
if (-Not (Test-Path -Path $path)) {
  Write-Host "not found package.json in current directory."
  exit 1
}
$json = (Get-Content -Path $path | ConvertFrom-Json)
$deps = $json.dependencies.PSObject.Properties.Name + $json.devDependencies.PSObject.Properties.Name
$today = Get-Date
Write-Host "scanning packages..."

$output = @()
foreach ($pkg in $deps) {
  try {
    $lastMod = npm view $pkg time.modified --json 2>$null | ConvertFrom-Json;
    $date = [DateTime]$lastMod;
    $daysAgo = $today - $date;
    $output += [PSCustomObject]@{
      Package = $pkg
      LastModified = $date.ToString("yyyy-MM-dd")
      DaysAgo = [math]::Floor($daysAgo.TotalDays)
    };

  } catch {
    Write-Host "Error no such package: $pkg"
    exit 1
  }
}

Write-Host "finished scanning!"
$output | Sort-Object DaysAgo -Descending | Format-Table -AutoSize;

Write-Host "packages not updated for more than 1 year"
$output | Where-Object { $_.DaysAgo -ge 365 } | Sort-Object DaysAgo -Descending | Format-Table -AutoSize;
Write-Host "----------------------------------------------"
