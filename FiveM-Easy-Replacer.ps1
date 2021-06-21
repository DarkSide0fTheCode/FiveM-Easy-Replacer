Write-Host "______              _     _____  _      _        _____   __  _____  _            _____             _       
|  _  \            | |   /  ___|(_)    | |      |  _  | / _||_   _|| |          /  __ \           | |      
| | | | __ _  _ __ | | __\ `--.  _   __| |  ___ | | | || |_   | |  | |__    ___ | /  \/  ___    __| |  ___ 
| | | |/ _` || '__|| |/ / `--. \| | / _` | / _ \| | | ||  _|  | |  | '_ \  / _ \| |     / _ \  / _` | / _ \
| |/ /| (_| || |   |   < /\__/ /| || (_| ||  __/\ \_/ /| |    | |  | | | ||  __/| \__/\| (_) || (_| ||  __/
|___/  \__,_||_|   |_|\_\\____/ |_| \__,_| \___| \___/ |_|    \_/  |_| |_| \___| \____/ \___/  \__,_| \___|`n`n" -ForegroundColor green

Start-Sleep -s 1

Write-Host "Welcome, this is a simple tool built with the intent to making mass replacing of fixed content strings easier/faster`n
You will be asked to specify the parent folder and some preferences to suite to your needs`n`n"

Write-Host "Press any key to start :)`n";
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

DO 
{
    $custom_framework = Read-Host -Prompt "`nInput you replacement to events, if you don't have one type 'N/n'"
} Until ($custom_framework)

DO 
{
    $custom_sql_library = Read-Host -Prompt "`nWhat are you using as SQL library?`n 1) MySQL (default)`n 2) GHMattiMySql`n"
} Until ( ( $custom_sql_library -eq 1 ) -or ( $custom_sql_library -eq 2 ) ) 

Write-Host "`nPress any key to choose the parent folder (files in subdirectories will be processed too)";
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Add-Type -AssemblyName System.Windows.Forms
$file_browser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $file_browser.ShowDialog()
$target_folder = $file_browser.SelectedPath
$target_files = Get-ChildItem $target_folder *.lua -Recurse -Force
$log = ""

if ( $custom_framework -ne 'N' )
{
    foreach ($file in $target_files)
    {
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -creplace "\besx\b", $custom_framework } |
        Set-Content $file.PSPath
        $log = $log + $file.fullname + "`n"
    }

}

if ( $custom_sql_library -eq 2)
{
    foreach ($file in $target_files)
    {
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -creplace "MySQL.Async.fetchAll", "exports.ghmattimysql:execute" } |
        Foreach-Object { $_ -creplace "MySQL.Sync.fetchAll", "exports.ghmattimysql:executeSync" } |
        Foreach-Object { $_ -creplace "MySQL.Async.execute", "exports.ghmattimysql:execute" } |
        Foreach-Object { $_ -creplace "MySQL.Sync.execute", "exports.ghmattimysql:executeSync" } |
        Foreach-Object { $_ -creplace "MySQL.Sync.execute", "exports.ghmattimysql:executeSync" } |
        Set-Content $file.PSPath
    }

}

Write-Host "`nFinished`n";
Write-Host "Processed file/s`n";
Write-Host $log -ForegroundColor green;
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# SIG # Begin signature block
# MIIFcwYJKoZIhvcNAQcCoIIFZDCCBWACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUuClqqJl3uA696M9SjBIBjAwp
# HfGgggMMMIIDCDCCAfCgAwIBAgIQPOwyCxy+prFChNV65KGCPDANBgkqhkiG9w0B
# AQsFADAcMRowGAYDVQQDDBFEYXJrU2lkZU9mVGhlQ29kZTAeFw0yMTA2MjExMTE2
# MjNaFw0zMTA2MjExMTI2MjNaMBwxGjAYBgNVBAMMEURhcmtTaWRlT2ZUaGVDb2Rl
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA121L2s0UxoUtXWl1dlyd
# Ir/bnJ86XqdTqCRylNU+0n3tqgcpe6AfnHi1TguPm7WkdxbF3sYt1OAvr5qlWY5s
# K1HbPTdSwNz5hCZgltqyqSJQKXbJI1L3cR3/X3gJ6nBlXWafglNU+g9Ueaiq5oHX
# kKDehjz6PJ1HScMGDuqkJNAFJmqgJSubBNV+AWKrSW0xkVUajumc32q2MZV07L6/
# fG/KwLauY0EifhzHcDgpyHVqWVnG/iNaNMTMdfS+aMncs+gKsX4oXR7sEIoepyIg
# vZYc3XZWrEll/9U4t+H9qsRtWm1hhQoSUBj/gJgTYUdm7Ddd+85psqhQf0snkDjn
# dQIDAQABo0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMw
# HQYDVR0OBBYEFMTaaHHTqU+RnoP2zYiLfT4iVt+nMA0GCSqGSIb3DQEBCwUAA4IB
# AQBwe9BefP2gEbN/GacLox9L7pzCIhXe9BPQ75Lwy3f04cCiKwG3vBD59Il1F+o9
# PF6zu6dI1cZnQLEDCg9QCTQ0ApjTNTAqJNt2y67Y09drorZWMDjcpBAYkgXrLc54
# N1AovtuUo0TtQzk+WKh1jDsWfJPnP3TRd0B215kiu4fscDfNaHDCnPQXt/IC0l8n
# 4DJKcZEgnHnMwz9nL12o9R3zFGXJX2RP3b9uSpBcs437msECwJeuyLQKB91XlklE
# 1ixVoGsz4HQD9BVql7cjHJNB7DlRsO7FQYfFAWXHerPZmewcmEnpuhYG4gP3Wk86
# tpOaDTOs8nSFAz6DnwET7HFQMYIB0TCCAc0CAQEwMDAcMRowGAYDVQQDDBFEYXJr
# U2lkZU9mVGhlQ29kZQIQPOwyCxy+prFChNV65KGCPDAJBgUrDgMCGgUAoHgwGAYK
# KwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIB
# BDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU
# P90pEecxY5e0h5YrhFHgf2tmX9UwDQYJKoZIhvcNAQEBBQAEggEAmmmwVhHGIYj7
# 67fXjmKCUk+VHtw+3qOs8WReJlAp5HnU/5YaPe6QuGRbR79mYg+RYG3FnufK9I7t
# uutRgBjaLsLKqPyshgTQ5DRCm9mscdSdVUKnpGV1+yV8O5CmFFfcfzQCgZ2kWVYf
# AP+FJG1Ln0wIY97VKoDZXPXpb6yUDkFP7XZZWEYBJSEuhA5NXKZ/693G5Fh72kJ/
# oTNkQqW/bWnTaBWcBDfVuRn8zm60zPM0CpWJh2clg43FUt/CJCdkukIxcgmBRDDr
# 6rawoLwgVjDbve8+J+xO2weCu93xsakBc6ZWCbCZK2wzIWfEZ3ks2QyYV69K64bl
# iEA8bUtZlw==
# SIG # End signature block
