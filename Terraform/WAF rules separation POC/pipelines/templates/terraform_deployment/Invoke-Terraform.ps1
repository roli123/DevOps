param (
    [Parameter(Mandatory = $true)]
    [string] $SubscriptionId,
    [Parameter(Mandatory = $true)]
    [string] $Environment,
    [Parameter(Mandatory = $true)]
    [string] $Domain,
    [Parameter(Mandatory = $true)]
    [string] $Capability,
    [Parameter(Mandatory = $true)]
    [string] $Application,
    [Parameter(Mandatory = $true)]
    [string] $WorkingDirectory,
    [Parameter(Mandatory = $true)]
    [bool] $RunImports,
    [Parameter(Mandatory = $true)]
    [bool] $PlanOnly,
    [Parameter(Mandatory = $true)]
    [bool] $Destroy,
    [Parameter(Mandatory = $true)]
    [bool] $RefreshState
)

Get-AzContext

Import-Module AvidXchange.CICD.Terraform

Invoke-TerraformInit `
    -SubscriptionId $SubscriptionId `
    -Environment $Environment `
    -Domain $Domain `
    -Capability $Capability `
    -Application $Application `
    -WorkingDirectory $WorkingDirectory `
    -Verbose

Write-Host "WorkingDir: $WorkingDirectory"

$RemoveBeforeImport = $true
$ShouldImportExistingResources = $true
if ($ShouldImportExistingResources) {
    & $PSScriptRoot"\Import-Existing-Resources.ps1" `
        -Environment $Environment `
        -SubscriptionId $SubscriptionId `
        -WorkingDirectory $WorkingDirectory `
        -RemoveBeforeImport $RemoveBeforeImport
}

<#
if($RunImports) {

    Write-Host "Running Terraform Imports"

    $resources = [System.Collections.ArrayList]::new()
    $importCommands = [System.Collections.ArrayList]::new()
    
    gci env: | foreach-object {
      if($_.Name.StartsWith("tfImport_")) {
        $address = $_.Name.Replace("tfImport_","").Replace("_dot_", ".")
        $id = $_.Value
        $resources.Add([pscustomobject]@{
            Address = $address;
            Id      = $id
        })
      }
    }
    
    foreach ($resource in $resources) {
        [void]$importCommands.Add("terraform -chdir='${WorkingDirectory}' import -input=false -var-file='pipeline.tfvars' $($resource.Address) '$($resource.Id)'")
    }
    
    Write-Host "Import Commands:"
    foreach ($importCommand in $importCommands) {
        Write-Host $importCommand
    }
    
    Write-Host "Attempting Importing Of Resources"
    $importCommands | Invoke-Expression | Out-Default  
    
    Write-Host "Listing resources..."
    terraform -chdir="${WorkingDirectory}" state list    
}
#>

if ($Destroy) {
    # Invoke-TerraformDestroy -VarFile "pipeline.tfvars" -WorkingDirectory $WorkingDirectory -Force
}
elseif ($PlanOnly) {
    Invoke-TerraformPlan -VarFile "pipeline.tfvars" -WorkingDirectory $WorkingDirectory
}
else {
    Invoke-TerraformApply -VarFile "exclusions.tfvars" -WorkingDirectory $WorkingDirectory -Force -OptionList @("-refresh=${RefreshState}")
}
    