param(
    [string]$OutputFile = 'archive (4).zip'
)

$part1 = 'archive (4).zip.part01'
$part2 = 'archive (4).zip.part02'

if (!(Test-Path -LiteralPath $part1) -or !(Test-Path -LiteralPath $part2)) {
    Write-Error "Missing split parts. Expected '$part1' and '$part2' in the current directory."
    exit 1
}

$outPath = Join-Path (Get-Location) $OutputFile
$in1 = [System.IO.File]::OpenRead((Join-Path (Get-Location) $part1))
$in2 = [System.IO.File]::OpenRead((Join-Path (Get-Location) $part2))
$out = [System.IO.File]::Create($outPath)

try {
    $in1.CopyTo($out)
    $in2.CopyTo($out)
}
finally {
    $in1.Dispose()
    $in2.Dispose()
    $out.Dispose()
}

Write-Host "Created $OutputFile"
