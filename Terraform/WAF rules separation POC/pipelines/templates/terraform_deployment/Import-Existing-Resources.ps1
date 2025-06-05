param (
    [Parameter(Mandatory)]
    [string] $WorkingDirectory,
    [Parameter(Mandatory)]
    [string] $SubscriptionId,
    [Parameter(Mandatory)]
    [string] $Environment,
    [boolean] $RemoveBeforeImport
)

# display_name                 = "Microsoft Graph"
# azuread_service_principal.sp 
# azuread_service_principal_delegated_permission_grant.user_grant 

if ($Environment -Match "Pr") {
    $directoryGrantId = ""
    $azureadAppId = ""
    $msgraphSpId = ""
    $spId = ""
    $userGrantId = ""
    $passwordId = ""
}
elseif ($Environment -Match "Dv") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/54mz11gkbkusYyl2hcBo6v12hGHBXoVNuSql-U4PxQE"
    $azureadAppId = "d19fa136-371e-4ec4-bf0f-68a7eebcd89b"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "d7b389e7-2458-4b6e-ac63-297685c068ea"
    $userGrantId = "54mz11gkbkusYyl2hcBo6pFlnMExvctOuM6E7H0Nw78"
    $passwordId = "d19fa136-371e-4ec4-bf0f-68a7eebcd89b/password/9e9490e6-d729-40c3-8b5c-c6fd48ca86ae"
}
elseif ($Environment -Match "Ci") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/bSmGIM4fC0q8W7zO3Fjrebgun5enXWBGu7cqQatxN0s"
    $azureadAppId = "ab6e01fc-8444-4b16-a51a-1791be257e02"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "2086296d-1fce-4a0b-bc5b-bccedc58eb79"
    $userGrantId = "bSmGIM4fC0q8W7zO3FjreZFlnMExvctOuM6E7H0Nw78"
    $passwordId = "ab6e01fc-8444-4b16-a51a-1791be257e02/password/7b303d29-89a0-4b64-9634-01c076349624"
}
elseif ($Environment -Match "Qa") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/c_IdQmMDOEK0x42083gFBHfTZKlaLDRFk4mSsVhuDLE"
    $azureadAppId = "75535142-c404-4ac3-b78a-080a530c7f98"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "421df273-0363-4238-b4c7-8db4f3780504"
    $userGrantId = "c_IdQmMDOEK0x42083gFBJFlnMExvctOuM6E7H0Nw78"
    $passwordId = "75535142-c404-4ac3-b78a-080a530c7f98/password/5683d6ee-6bc5-42de-968f-8161154a024a"
}
elseif ($Environment -Match "Ft") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/VxmFZguceUKLBvcTf8JeKZ7xS5bdHmVBnEzgSmcbjVw"
    $azureadAppId = "f984ae43-de1d-49c7-b2b3-18b6e43b2efd"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "66851957-9c0b-4279-8b06-f7137fc25e29"
    $userGrantId = "VxmFZguceUKLBvcTf8JeKZFlnMExvctOuM6E7H0Nw78"
    $passwordId = "f984ae43-de1d-49c7-b2b3-18b6e43b2efd/password/49e9afe5-f38a-4799-a4c2-194b6c38a7a8"
}
elseif ($Environment -Match "Ut") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/ZiklGcfhEEKy3WjpB3PGrkOjvNCkBQVChyCtOEGt-i0"
    $azureadAppId = "095450ec-2e4a-4bd1-9dee-b5e3ac4423c9"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "19252966-e1c7-4210-b2dd-68e90773c6ae"
    $userGrantId = "ZiklGcfhEEKy3WjpB3PGrpFlnMExvctOuM6E7H0Nw78"
    $passwordId = "095450ec-2e4a-4bd1-9dee-b5e3ac4423c9/password/8434bc51-bca4-4601-90b2-2b5a2e3614af"
}
elseif ($Environment -Match "Nt") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/Gy1gA6rDhUa1leYcFYmYNAk8bea31CpAonq5cnnllZI"
    $azureadAppId = "51874e2d-4d5c-4837-9f4a-0249acb3d3e8"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "03602d1b-c3aa-4685-b595-e61c15899834"
    $userGrantId = "Gy1gA6rDhUa1leYcFYmYNJFlnMExvctOuM6E7H0Nw78"
    $passwordId = "51874e2d-4d5c-4837-9f4a-0249acb3d3e8/password/220bda02-b908-467d-89a8-bdc562330dbf"
}
elseif ($Environment -Match "St") {
    $directoryGrantId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf/appRoleAssignment/xWe1X64dSUa2k_VTne3psatevEWCb3xGgirHcEhbiDA"
    $azureadAppId = "d95898e2-1e89-489f-ae2b-5ed1c4be5d8e"
    $msgraphSpId = "c19c6591-bd31-4ecb-b8ce-84ec7d0dc3bf"
    $spId = "5fb567c5-1dae-4649-b693-f5539dede9b1"
    $userGrantId = "xWe1X64dSUa2k_VTne3psZFlnMExvctOuM6E7H0Nw78"
    $passwordId = "d95898e2-1e89-489f-ae2b-5ed1c4be5d8e/password/e323c935-0fec-4970-9a69-85b4641ad40b"
}


$resources = [System.Collections.ArrayList]::new()
$removeCommands = [System.Collections.ArrayList]::new()
$importCommands = [System.Collections.ArrayList]::new()

# Set your list of resources here that you want to remove/import!
# NOTE: since this capability repo has two pipelines, I'm declaring different lists based on Prod/NonProd vs standard Dv-Pr stages


# Capability resources
$resources.AddRange(
    [System.Collections.ArrayList]@(
        <#
        [pscustomobject]@{
            Address = "azuread_app_role_assignment.directory_grant";
            Id      = $directoryGrantId
        },
        [pscustomobject]@{
            Address = "azuread_application.app";
            Id      = $azureadAppId
        },
        [pscustomobject]@{
            Address = "azuread_service_principal.msgraph";
            Id      = $msgraphSpId
        },
        [pscustomobject]@{
            Address = "azuread_service_principal.sp";
            Id      = $spId
        },
        [pscustomobject]@{
            Address = "azuread_service_principal_delegated_permission_grant.user_grant";
            Id      = $userGrantId
        }
            #>
    )
)


foreach ($resource in $resources) {
    [void]$removeCommands.Add("terraform -chdir='${WorkingDirectory}' state rm $($resource.Address)")
    [void]$importCommands.Add("terraform -chdir='${WorkingDirectory}' import -input=false -var-file='pipeline.tfvars' $($resource.Address) $($resource.Id)")
}

Write-Verbose "Remove Commands:"
foreach ($removeCommand in $removeCommands) {
    Write-Verbose $removeCommand
}

Write-Verbose "Import Commands:"
foreach ($importCommand in $importCommands) {
    Write-Host $importCommand
    Write-Verbose $importCommand
}

# NOTE: From my research, removing before importing isn't really necessary.
# TF will report an error on import that the resource is already managed, but it doesn't break the build.
# If you want a cleaner log, uncomment this, but otherwise it doesn't seem to make any functional difference
if ($RemoveBeforeImport) {
    Write-Verbose "Attempting Removing Resources from state"
    $removeCommands | Invoke-Expression | Out-Default   
}

Write-Verbose "Attempting Importing Of Resources"
$importCommands | Invoke-Expression | Out-Default  

Write-Verbose "Listing resources..."
terraform -chdir="${WorkingDirectory}" state list