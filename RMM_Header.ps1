# =========================
# ASCII HEADER
# =========================
$AsciiHeader = @"
                                                                                 
                                                                                 
█████▄ ▄▄▄▄   ▄▄▄   ▄▄▄▄ ▄▄   ▄▄  ▄▄▄    ▄█████  ▄▄▄  ▄▄▄▄  ▄▄ ▄▄▄▄▄▄ ▄▄▄  ▄▄    
██▄▄█▀ ██▄█▄ ██▀██ ██ ▄▄ ██▀▄▀██ ██▀██   ██     ██▀██ ██▄█▀ ██   ██  ██▀██ ██    
██     ██ ██ ██▀██ ▀███▀ ██   ██ ██▀██   ▀█████ ██▀██ ██    ██   ██  ██▀██ ██▄▄▄ 
                                                                                 
        RMM Agent Deployment
        © $(Get-Date -Format yyyy) Departamento de TI
-------------------------------------------------------------
"@

Clear-Host
Write-Host $AsciiHeader -ForegroundColor Cyan

# =========================
# CONFIGURATION
# =========================

$deploymenturl = "https://api.pragmacapital.app/clients/51c69bf7-b6a4-4e58-a3c5-2dc122c43ec1/deploy/"
$agentstoinstall = 1 # Replace with the number of agents to install if greater than 20

# =========================
# EXECUTION LOGIC
# =========================

$randomSleepTime = if ($agentstoinstall -gt 1) {
    Get-Random -Minimum 1 -Maximum (($agentstoinstall + 1) * 2)
} else {
    1
}

Write-Host "[INFO] Waiting $randomSleepTime seconds before installation..." -ForegroundColor Yellow
Start-Sleep -Seconds $randomSleepTime

$installerPath = "C:\ProgramData\TacticalRMM\temp\trmminstall.exe"

Write-Host "[INFO] Downloading Tactical RMM agent..." -ForegroundColor Yellow
Invoke-WebRequest $deploymenturl -OutFile (New-Item -Path $installerPath -Force)

Write-Host "[INFO] Installing agent silently..." -ForegroundColor Yellow
$proc = Start-Process $installerPath -ArgumentList '-silent' -PassThru
Wait-Process -InputObject $proc

if ($proc.ExitCode -ne 0) {
    Write-Warning "[ERROR] Installer exited with status code $($proc.ExitCode)"
} else {
    Write-Host "[SUCCESS] Agent installed successfully." -ForegroundColor Green
}

Write-Host "[INFO] Cleaning up installer..." -ForegroundColor Yellow
Remove-Item -Path $installerPath -Force

# SIG # Begin signature block
# MIIfCgYJKoZIhvcNAQcCoIIe+zCCHvcCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU4I96VfQT1vrPNt6wQkinNCLp
# 9xqgghh0MIIFNjCCAx6gAwIBAgIQPEov7dYsn7dMh/xhy7Q7qTANBgkqhkiG9w0B
# AQsFADAhMR8wHQYDVQQDDBZFbnRlcnByaXNlLUNvZGVTaWduaW5nMB4XDTI2MDEw
# ODIwNTkzNFoXDTMxMDEwODIxMDkzM1owITEfMB0GA1UEAwwWRW50ZXJwcmlzZS1D
# b2RlU2lnbmluZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOTl4rlT
# ejpfZTClx4KWeB3CJ0wBFAJ9banWB3WiQH9eFrpxmANyI4KVrOu3yLnyXlbvQ26E
# 0WlcHJZyhukamoV3Ry18I0zeZmN64tZUxe3DdHMN+mXnIrmXMYRJ3xv/a7B2tgKm
# Wtpxcq4W5i+7Rm7o43w8AY6RvJUgAlhFg4CL/dNhBy53MiysdQ9QEppW1SPUp0gp
# zOxSMD19n5fj4e3eKa0wR+D6T/pd3Rqu4Efrqc3KYtv5hR0mS+EeX/FNEQdyLRgo
# z5+pxo6G7QUuCvQXORSnIdsQx6h9TLZFnpPeozSXv35ovsiyoJgvmHKF+rfLnPCM
# ZlRlVWZo/mLY8OH1LSCzMM11PkYszZWyB/cMncrNwD6iPzAb4vWCyYyVcuPzpGEn
# Axfc9EnJS/xVqiawypCRLWk+VzeDpbdTCXypekF59oYFOttSnObqDnvJnLgIr6T8
# SC0RW8hnUnmqqgfgsO7X/rtXcBuE/KYNOJrHca2W/2LMJIQNcQ5BHdG4GzVAcyTc
# BfnAnuIIL3weuA5xDQRHu9WQeESRzRDS1vgOnwCMF65zp6ewu4GYmeUhJsG618gk
# B+S6Gi/qB8Y3LVCHNH0RQEyBS1WPXvFIn9Zi/Njc98uHIbVYnNmoNR/FybcjW2uj
# KzuIoya78UPI+nj9BvEZR71RJG1ussBymkKhAgMBAAGjajBoMA4GA1UdDwEB/wQE
# AwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAiBgNVHREEGzAZghdpbnRlcm5hbC5j
# b2Rlc2lnbi5sb2NhbDAdBgNVHQ4EFgQUjpa9qPZMyWGt+tqILXZTy+z1oQEwDQYJ
# KoZIhvcNAQELBQADggIBAFJKcBJhcrvcE/yu7zgt9i23I8uX7Gf8vSJbE90lwnEH
# xRt7oPZZYidtbnoY2q1mtia2bDWgO0noxUECcHt+5s/7c7Ydnnx2RpLLFyi6wVoY
# jeVyEy7OYOP/SXHKfjYZQ5C2TiQIhrp8waUYkigtpipkwPhwi+grmwyNPmMCiIib
# gn5RYZtSJi0DPk+BWhGWDOnwVH6QZC0z7EASoQa6tDVjrGa/TS3/BtqBfieq3lL9
# ffbF7dHH6XJe9qRAMBZBXT4eJCM83LhbPlsoeu12bKHpf8yyqkPbM++V/RbIeRmU
# JqUbziBoidG+EC/M5TEhKe+a8VQMnzXHiAcJAV9pq7sdSiZ6n+5flQprmjqQtlKG
# pJ60FBiB07hoRXI+WLxqipiN6YVMvf0xS7O4MP0EDw/G/VYsDvLoCkRlYP/nVJSk
# xjlnq9nHUv2Iw6RJ818C1gTK5QLK4/eYMdgf2DT6qVucdzSnuikFsGiAMQJTE3/c
# JQ7ON3usXrXMxF1fgWnWKYoeXsVH0OSNnRZgUmBoVvRFbivUBvq8023lEMX/WTBE
# 4QnZuuFB0m6SLqR2WAk5cyhKVzg6eDxInq3Npv/gIX4qQW0Giob1XjMGgAktaCYb
# ihK+MwLxpWnU2Hg+cdWZtKHL1aJipmrp+ImyRNQyhhvqpZ2XvHJP7E9rrBIRIZTh
# MIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkqhkiG9w0BAQwFADBl
# MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
# d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJv
# b3QgQ0EwHhcNMjIwODAxMDAwMDAwWhcNMzExMTA5MjM1OTU5WjBiMQswCQYDVQQG
# EwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNl
# cnQuY29tMSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJvb3QgRzQwggIiMA0G
# CSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC/5pBzaN675F1KPDAiMGkz7MKnJS7J
# IT3yithZwuEppz1Yq3aaza57G4QNxDAf8xukOBbrVsaXbR2rsnnyyhHS5F/WBTxS
# D1Ifxp4VpX6+n6lXFllVcq9ok3DCsrp1mWpzMpTREEQQLt+C8weE5nQ7bXHiLQwb
# 7iDVySAdYyktzuxeTsiT+CFhmzTrBcZe7FsavOvJz82sNEBfsXpm7nfISKhmV1ef
# VFiODCu3T6cw2Vbuyntd463JT17lNecxy9qTXtyOj4DatpGYQJB5w3jHtrHEtWoY
# OAMQjdjUN6QuBX2I9YI+EJFwq1WCQTLX2wRzKm6RAXwhTNS8rhsDdV14Ztk6MUSa
# M0C/CNdaSaTC5qmgZ92kJ7yhTzm1EVgX9yRcRo9k98FpiHaYdj1ZXUJ2h4mXaXpI
# 8OCiEhtmmnTK3kse5w5jrubU75KSOp493ADkRSWJtppEGSt+wJS00mFt6zPZxd9L
# BADMfRyVw4/3IbKyEbe7f/LVjHAsQWCqsWMYRJUadmJ+9oCw++hkpjPRiQfhvbfm
# Q6QYuKZ3AeEPlAwhHbJUKSWJbOUOUlFHdL4mrLZBdd56rF+NP8m800ERElvlEFDr
# McXKchYiCd98THU/Y+whX8QgUWtvsauGi0/C1kVfnSD8oR7FwI+isX4KJpn15Gkv
# mB0t9dmpsh3lGwIDAQABo4IBOjCCATYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4E
# FgQU7NfjgtJxXWRM3y5nP+e6mK4cD08wHwYDVR0jBBgwFoAUReuir/SSy4IxLVGL
# p6chnfNtyA8wDgYDVR0PAQH/BAQDAgGGMHkGCCsGAQUFBwEBBG0wazAkBggrBgEF
# BQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAChjdodHRw
# Oi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0Eu
# Y3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9E
# aWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
# CSqGSIb3DQEBDAUAA4IBAQBwoL9DXFXnOF+go3QbPbYW1/e/Vwe9mqyhhyzshV6p
# Grsi+IcaaVQi7aSId229GhT0E0p6Ly23OO/0/4C5+KH38nLeJLxSA8hO0Cre+i1W
# z/n096wwepqLsl7Uz9FDRJtDIeuWcqFItJnLnU+nBgMTdydE1Od/6Fmo8L8vC6bp
# 8jQ87PcDx4eo0kxAGTVGamlUsLihVo7spNU96LHc/RzY9HdaXFSMb++hUD38dglo
# hJ9vytsgjTVgHAIDyyCwrFigDkBjxZgiwbJZ9VVrzyerbHbObyMt9H5xaiNrIv8S
# uFQtJ37YOtnwtoeW/VvRXKwYw02fc7cBqZ9Xql4o4rmUMIIGtDCCBJygAwIBAgIQ
# DcesVwX/IZkuQEMiDDpJhjANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJvb3QgRzQwHhcNMjUwNTA3MDAw
# MDAwWhcNMzgwMTE0MjM1OTU5WjBpMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGln
# aUNlcnQsIEluYy4xQTA/BgNVBAMTOERpZ2lDZXJ0IFRydXN0ZWQgRzQgVGltZVN0
# YW1waW5nIFJTQTQwOTYgU0hBMjU2IDIwMjUgQ0ExMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEAtHgx0wqYQXK+PEbAHKx126NGaHS0URedTa2NDZS1mZaD
# LFTtQ2oRjzUXMmxCqvkbsDpz4aH+qbxeLho8I6jY3xL1IusLopuW2qftJYJaDNs1
# +JH7Z+QdSKWM06qchUP+AbdJgMQB3h2DZ0Mal5kYp77jYMVQXSZH++0trj6Ao+xh
# /AS7sQRuQL37QXbDhAktVJMQbzIBHYJBYgzWIjk8eDrYhXDEpKk7RdoX0M980EpL
# tlrNyHw0Xm+nt5pnYJU3Gmq6bNMI1I7Gb5IBZK4ivbVCiZv7PNBYqHEpNVWC2ZQ8
# BbfnFRQVESYOszFI2Wv82wnJRfN20VRS3hpLgIR4hjzL0hpoYGk81coWJ+KdPvMv
# aB0WkE/2qHxJ0ucS638ZxqU14lDnki7CcoKCz6eum5A19WZQHkqUJfdkDjHkccpL
# 6uoG8pbF0LJAQQZxst7VvwDDjAmSFTUms+wV/FbWBqi7fTJnjq3hj0XbQcd8hjj/
# q8d6ylgxCZSKi17yVp2NL+cnT6Toy+rN+nM8M7LnLqCrO2JP3oW//1sfuZDKiDEb
# 1AQ8es9Xr/u6bDTnYCTKIsDq1BtmXUqEG1NqzJKS4kOmxkYp2WyODi7vQTCBZtVF
# JfVZ3j7OgWmnhFr4yUozZtqgPrHRVHhGNKlYzyjlroPxul+bgIspzOwbtmsgY1MC
# AwEAAaOCAV0wggFZMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFO9vU0rp
# 5AZ8esrikFb2L9RJ7MtOMB8GA1UdIwQYMBaAFOzX44LScV1kTN8uZz/nupiuHA9P
# MA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDCDB3BggrBgEFBQcB
# AQRrMGkwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBBBggr
# BgEFBQcwAoY1aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1
# c3RlZFJvb3RHNC5jcnQwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybDMuZGln
# aWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZFJvb3RHNC5jcmwwIAYDVR0gBBkwFzAI
# BgZngQwBBAIwCwYJYIZIAYb9bAcBMA0GCSqGSIb3DQEBCwUAA4ICAQAXzvsWgBz+
# Bz0RdnEwvb4LyLU0pn/N0IfFiBowf0/Dm1wGc/Do7oVMY2mhXZXjDNJQa8j00DNq
# hCT3t+s8G0iP5kvN2n7Jd2E4/iEIUBO41P5F448rSYJ59Ib61eoalhnd6ywFLery
# cvZTAz40y8S4F3/a+Z1jEMK/DMm/axFSgoR8n6c3nuZB9BfBwAQYK9FHaoq2e26M
# HvVY9gCDA/JYsq7pGdogP8HRtrYfctSLANEBfHU16r3J05qX3kId+ZOczgj5kjat
# VB+NdADVZKON/gnZruMvNYY2o1f4MXRJDMdTSlOLh0HCn2cQLwQCqjFbqrXuvTPS
# egOOzr4EWj7PtspIHBldNE2K9i697cvaiIo2p61Ed2p8xMJb82Yosn0z4y25xUbI
# 7GIN/TpVfHIqQ6Ku/qjTY6hc3hsXMrS+U0yy+GWqAXam4ToWd2UQ1KYT70kZjE4Y
# tL8Pbzg0c1ugMZyZZd/BdHLiRu7hAWE6bTEm4XYRkA6Tl4KSFLFk43esaUeqGkH/
# wyW4N7OigizwJWeukcyIPbAvjSabnf7+Pu0VrFgoiovRDiyx3zEdmcif/sYQsfch
# 28bZeUz2rtY/9TCA6TD8dC3JE3rYkrhLULy7Dc90G6e8BlqmyIjlgp2+VqsS9/wQ
# D7yFylIz0scmbKvFoW2jNrbM1pD2T7m3XDCCBu0wggTVoAMCAQICEAqA7xhLjfEF
# gtHEdqeVdGgwDQYJKoZIhvcNAQELBQAwaTELMAkGA1UEBhMCVVMxFzAVBgNVBAoT
# DkRpZ2lDZXJ0LCBJbmMuMUEwPwYDVQQDEzhEaWdpQ2VydCBUcnVzdGVkIEc0IFRp
# bWVTdGFtcGluZyBSU0E0MDk2IFNIQTI1NiAyMDI1IENBMTAeFw0yNTA2MDQwMDAw
# MDBaFw0zNjA5MDMyMzU5NTlaMGMxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdp
# Q2VydCwgSW5jLjE7MDkGA1UEAxMyRGlnaUNlcnQgU0hBMjU2IFJTQTQwOTYgVGlt
# ZXN0YW1wIFJlc3BvbmRlciAyMDI1IDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDQRqwtEsae0OquYFazK1e6b1H/hnAKAd/KN8wZQjBjMqiZ3xTWcfsL
# wOvRxUwXcGx8AUjni6bz52fGTfr6PHRNv6T7zsf1Y/E3IU8kgNkeECqVQ+3bzWYe
# sFtkepErvUSbf+EIYLkrLKd6qJnuzK8Vcn0DvbDMemQFoxQ2Dsw4vEjoT1FpS54d
# NApZfKY61HAldytxNM89PZXUP/5wWWURK+IfxiOg8W9lKMqzdIo7VA1R0V3Zp3Dj
# jANwqAf4lEkTlCDQ0/fKJLKLkzGBTpx6EYevvOi7XOc4zyh1uSqgr6UnbksIcFJq
# LbkIXIPbcNmA98Oskkkrvt6lPAw/p4oDSRZreiwB7x9ykrjS6GS3NR39iTTFS+EN
# TqW8m6THuOmHHjQNC3zbJ6nJ6SXiLSvw4Smz8U07hqF+8CTXaETkVWz0dVVZw7kn
# h1WZXOLHgDvundrAtuvz0D3T+dYaNcwafsVCGZKUhQPL1naFKBy1p6llN3QgshRt
# a6Eq4B40h5avMcpi54wm0i2ePZD5pPIssoszQyF4//3DoK2O65Uck5Wggn8O2klE
# TsJ7u8xEehGifgJYi+6I03UuT1j7FnrqVrOzaQoVJOeeStPeldYRNMmSF3voIgMF
# tNGh86w3ISHNm0IaadCKCkUe2LnwJKa8TIlwCUNVwppwn4D3/Pt5pwIDAQABo4IB
# lTCCAZEwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU5Dv88jHt/f3X85FxYxlQQ89h
# jOgwHwYDVR0jBBgwFoAU729TSunkBnx6yuKQVvYv1Ensy04wDgYDVR0PAQH/BAQD
# AgeAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMIGVBggrBgEFBQcBAQSBiDCBhTAk
# BggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMF0GCCsGAQUFBzAC
# hlFodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkRzRU
# aW1lU3RhbXBpbmdSU0E0MDk2U0hBMjU2MjAyNUNBMS5jcnQwXwYDVR0fBFgwVjBU
# oFKgUIZOaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0
# VGltZVN0YW1waW5nUlNBNDA5NlNIQTI1NjIwMjVDQTEuY3JsMCAGA1UdIAQZMBcw
# CAYGZ4EMAQQCMAsGCWCGSAGG/WwHATANBgkqhkiG9w0BAQsFAAOCAgEAZSqt8Rwn
# BLmuYEHs0QhEnmNAciH45PYiT9s1i6UKtW+FERp8FgXRGQ/YAavXzWjZhY+hIfP2
# JkQ38U+wtJPBVBajYfrbIYG+Dui4I4PCvHpQuPqFgqp1PzC/ZRX4pvP/ciZmUnth
# fAEP1HShTrY+2DE5qjzvZs7JIIgt0GCFD9ktx0LxxtRQ7vllKluHWiKk6FxRPyUP
# xAAYH2Vy1lNM4kzekd8oEARzFAWgeW3az2xejEWLNN4eKGxDJ8WDl/FQUSntbjZ8
# 0FU3i54tpx5F/0Kr15zW/mJAxZMVBrTE2oi0fcI8VMbtoRAmaaslNXdCG1+lqvP4
# FbrQ6IwSBXkZagHLhFU9HCrG/syTRLLhAezu/3Lr00GrJzPQFnCEH1Y58678Igmf
# ORBPC1JKkYaEt2OdDh4GmO0/5cHelAK2/gTlQJINqDr6JfwyYHXSd+V08X1JUPvB
# 4ILfJdmL+66Gp3CSBXG6IwXMZUXBhtCyIaehr0XkBoDIGMUG1dUtwq1qmcwbdUfc
# SYCn+OwncVUXf53VJUNOaMWMts0VlRYxe5nK+At+DI96HAlXHAL5SlfYxJ7La54i
# 71McVWRP66bW+yERNpbJCjyCYG2j+bdpxo/1Cy4uPcU3AWVPGrbn5PhDBf3Frogu
# zzhk++ami+r3Qrx5bIbY3TVzgiFI7Gq3zWcxggYAMIIF/AIBATA1MCExHzAdBgNV
# BAMMFkVudGVycHJpc2UtQ29kZVNpZ25pbmcCEDxKL+3WLJ+3TIf8Ycu0O6kwCQYF
# Kw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkD
# MQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJ
# KoZIhvcNAQkEMRYEFNSjd/qgOWRJbWfTW59t7VDARL58MA0GCSqGSIb3DQEBAQUA
# BIICAIBBP5ETWVl5TXEkNLQgPbZCryTez3aM1MO9L/95tW6WeaWJLA+B9saGLQAP
# JbwU40zpsOUyWos21MxWO6nQBeaaPTkbifeYas/cVuE5vApJVYMm8uBTSbUDWmwC
# 0y6s2YohSV45OHb1WzX7dEDnALq3zPzx+N2HphA1einEpVHL5jgaV+tkEZqwXa8r
# AR1WRla0/grJBIDhIZ8i3WkuDnFfa5c3ZjJiEEOtz/9g0YjF7F9OK3aZ1jBgDqLD
# nwn5qcG9Ef+iq2ImUzeVxoHKTLHu/a6cXeUCMWyEoZOk5xvwo4DwBIGft4UZesrF
# dzBfqwsTXvc77eqxGIMvifWRMMsMwuAH/yOPgvHw17yjRXg7w5l+N2tAq+72vqrT
# okKNrDqFn6/iMqsdxU7Y5XyYDg54QOPItqtppftpcSosikYmOvHd7VW+K2xlKgWQ
# +TtYZ7N0uSD5JErX8khvfXsgldB+I5U4w+SHBTGygxijaXlsbJTLEGuGJYHi47GE
# 0sBDPFLxhGC2BnDSxhclNd+KdjMUtGfWX4XRGnh0hcRXv2L9fgYmfv4WRxxWP6Xa
# oSpIfgarcxsD9bDVeyGMbXstUmct0Mpc3opWifFrftiZzYk/XnZErOHKJDpA2B7X
# gOfpTvELlJzv7wynC93BPyJ7WUwVjXpqZd1lAZpMcDNGMtRDoYIDJjCCAyIGCSqG
# SIb3DQEJBjGCAxMwggMPAgEBMH0waTELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRp
# Z2lDZXJ0LCBJbmMuMUEwPwYDVQQDEzhEaWdpQ2VydCBUcnVzdGVkIEc0IFRpbWVT
# dGFtcGluZyBSU0E0MDk2IFNIQTI1NiAyMDI1IENBMQIQCoDvGEuN8QWC0cR2p5V0
# aDANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
# KoZIhvcNAQkFMQ8XDTI2MDEwODIxNDAwOFowLwYJKoZIhvcNAQkEMSIEIF+a4Q3M
# Pkblvd6aVZ3VUEYddiLZYCITIjRyn1rOhBwvMA0GCSqGSIb3DQEBAQUABIICAGrJ
# 0cAj6j7U6cMPF9GGnrplcqUOmuy3LCOJZqAX6j7HkaQ5S/p10vCZEygVfJHU9zTu
# zZItJUkujNOb1rn4MVF13VWtzu8Jbt3FHJmKdmNCKvFPF52g1nJpm/zL77E4hkfy
# US8nL8HYbgnapPQX+zmBuF7BKufNuGV8ipy8BRqnJJ4b9jLBhmC1XfKytfwO2sZv
# T7p72dZUkQiPdYQGcbUK35JlEKbX8jBBsfU/9yxVZw8UUs6iRNRQ9HnElt/Cqgoc
# pqQU2uGggNmJK9jmpQaZja2B+JouKVZexr1V3nqNL/F/Ll+tpERfI1ZQ1YVTNplp
# YCMykspkPfvFCG/fSBK5g32W8tnBE866PYpOJngZAKPlexhwb9HXymhuVugcq8kH
# AM3J586i4t5qW/FEpLsbmBcZD5SHl0ZPOCdIyJS4G5w8+v+eWi0y8EObLtYJaRAI
# 5WmbGwqHPgkpurA3RLVqqIheobIkU+t0D9hdiYCfY8It4NLN2fkS88VLrajYnmzi
# 0xv219Z298gtjVrmtE7PSw9rRg3GsFFNTZbf4UtyKz4/lXc7zwXBQ3kta/4xPjr+
# WfpEb6LIYeVcZDLB84px9MPjDre6h12ly8IvLmTN1GwIrkL1cgpUCrAe7mevn+2N
# a+FxkUk/d2Fi+ygBUkVz3DYKT+I22TpLipM0WjaD
# SIG # End signature block
