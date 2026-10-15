# Regenera js\galeria-data.js a partir de las imagenes de la carpeta imggaleria\
# Uso: clic derecho -> "Ejecutar con PowerShell"  (o:  powershell -ExecutionPolicy Bypass -File .\actualizar-galeria.ps1)
Set-Location -Path $PSScriptRoot
$ext = '.jpg','.jpeg','.png','.webp','.gif','.avif'
$files = Get-ChildItem -Path 'imggaleria' -File | Where-Object { $ext -contains $_.Extension.ToLower() } |
         Sort-Object { $_.Name } -Culture 'en-US' | ForEach-Object { $_.Name }
$json = ($files | ForEach-Object { '  ' + (ConvertTo-Json $_) }) -join ",`n"
$content = "// Generado por actualizar-galeria.ps1 (no editar a mano)`nwindow.GALERIA = [`n$json`n];`n"
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot 'js\galeria-data.js'), $content, (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Galeria actualizada: $($files.Count) imagenes"
