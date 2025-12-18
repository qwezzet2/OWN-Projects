# Выводим только созданные нами правила
$rules = @(
    "Block_http_conn",
    "Allow_rdp_conn",
    "Block_ftp_conn",
    "Block_ping_conn"
)

$result = foreach ($rule in $rules) {
    $fwRule = Get-NetFirewallRule -DisplayName $rule
    $portFilter = Get-NetFirewallPortFilter -AssociatedNetFirewallRule $fwRule
    
    [PSCustomObject]@{
        RuleName    = $fwRule.DisplayName
        Enabled     = $fwRule.Enabled
        Protocol    = $portFilter.Protocol
        LocalPort   = $portFilter.LocalPort
        RemotePort  = $portFilter.RemotePort
        Action      = $fwRule.Action
        Profile     = $fwRule.Profile
    }
}

# Сохраняем результат в файл
$result | Format-Table -AutoSize | Out-File -FilePath "result.txt"

Write-Host "Правила сохранены в result.txt"