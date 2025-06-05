# Install modules if  missing
$moduleNames = @("Az.Accounts","Az.Network","Az.ApiManagement","Az.Storage")
foreach($moduleName in $moduleNames) {
  $module = Get-InstalledModule $moduleName -ErrorAction SilentlyContinue
  if(-not $module) {
      Write-Host "Installing Module ${moduleName}"
      Install-Module $moduleName -Force -AllowClobber -Repository PSGallery
  }
}