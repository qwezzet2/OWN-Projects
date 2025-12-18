# Проверка прав администратора
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Запустите скрипт от имени администратора!"
    Exit
}

# Экспорт политик
secedit /export /cfg secpol_2.txt
Write-Host "Политики сохранены в secpol.txt"