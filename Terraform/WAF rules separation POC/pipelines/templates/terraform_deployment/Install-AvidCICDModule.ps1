param (
    [Parameter(Mandatory = $false)]
    [switch] $SkipDependencies
)

Write-Verbose "Prepare credentials for the AvidXchange PS Gallery"
$patToken = $env:SYSTEM_ACCESSTOKEN | ConvertTo-SecureString -AsPlainText -Force
$repoCredential = New-Object System.Management.Automation.PSCredential($env:SYSTEM_ACCESSTOKEN, $patToken)

Write-Verbose "Checking if AvidPSGallery is configured"
$avidPsRepository = Get-PackageSource | Where-Object -Property 'Name' -eq 'AvidPSGallery'
if (-not $avidPsRepository) {
    Write-Verbose "Configuring AvidPSGallery"
    Register-PackageSource `
        -Name AvidPSGallery `
        -Location "https://pkgs.dev.azure.com/avidxchange/71d2903b-de95-484b-b203-f3ba0f32b19d/_packaging/powershell-modules/nuget/v2" `
        -Credential $repoCredential `
        -ProviderName PowerShellGet `
        -Trusted
}

if(-not $SkipDependencies) {
    # The Avid CICD Module requires AzKeyVault@3.4.0 which in turn requires Az.Accounts@>=2.2.5
    Write-Verbose "Installing dependency: Az.KeyVault @ 3.4.0"
    Install-Module -Name Az.KeyVault -RequiredVersion "3.4.0" -Force -Repository PSGallery -Verbose
    Import-Module -Name Az.KeyVault -RequiredVersion "3.4.0" -Verbose

    Write-Verbose "Installing dependency: Az.Accounts @ 2.2.5"
    Install-Module -Name Az.Accounts -MinimumVersion "2.2.5" -Force -Repository PSGallery -Verbose
    Import-Module -Name Az.Accounts -MinimumVersion "2.2.5" -Verbose
}

# Installing the module
Install-Module -Name AvidXchange.CICD.Terraform -Credential $repoCredential -Force
