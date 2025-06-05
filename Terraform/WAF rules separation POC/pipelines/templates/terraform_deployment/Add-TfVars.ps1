param(
  [string]$TfWorkingDirectory
)

New-Item -Path "${TfWorkingDirectory}/pipeline.tfvars" -ItemType File
gci env: | foreach-object {
  if($_.Name.StartsWith("tfVariable_")) {
    $var = $_.Name.Replace("tfVariable_","")
    $val = $_.Value
    Write-Host "Setting ${var} to ${val}" 
    Add-Content -Path "${TfWorkingDirectory}/pipeline.tfvars" -Value "${var} = `"${val}`"" 
  }
}
