Set-Location -Path $PSScriptRoot
Import-Module -Name ".\modules\Module.psm1"

function Invoke-Main {

    Get-HelloWorld
}

Invoke-Main