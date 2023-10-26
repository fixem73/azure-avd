<#
.SYNOPSIS
  Configures FSLogix on AVD

.DESCRIPTION
 Azure Runbook to configure FSLogix on an AVD deployment

.INPUTS
Resource Group Name

.OUTPUTS
Verbose output

.NOTES
  Version:        1.0
  Author:         Jimmy Lamon
  email:          jimmy.lamon@adiit.com
  Creation Date:  2023/10/11
  Purpose/Change: Initial script development

#>
param (
    [Parameter(Mandatory=$true)] 
    [String]  $RGName = 'Resource Group Name'
)
$Script = '

##########################
#   Configure FSLogix    #
##########################
& "C:\Program Files\FSLogix\Apps\frx.exe" add-secure-key -key cloudcachekey -value "BlobEndpoint=https://avduserprofiles.blob.core.usgovcloudapi.net/;QueueEndpoint=https://avduserprofiles.queue.core.usgovcloudapi.net/;TableEndpoint=https://avduserprofiles.table.core.usgovcloudapi.net/;FileEndpoint=https://avduserprofiles.file.core.usgovcloudapi.net/;AccountName=avduserprofiles;AccountKey=i6006lj2b2Tgndtm2pue3Fjk2drGLObEj/gn1VB9XCK6j0832Gtrufm3K4UxNVzC/9hd2pSVvJi9+AStxPw9jg=="
$ConnectionStringKey = "|fslogix/cloudcachekey|"
$ConnectionName = "AZURE Blob 1"
$ConnectionString = "type=azure,name=$ConnectionName,connectionString=$ConnectionStringKey"


if((Test-Path -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles") -ne $true) {  New-Item "HKLM:\SOFTWARE\FSLogix\Profiles" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "CCDLocations" -Value $ConnectionString -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "Enabled" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "DeleteLocalProfileWhenVHDShouldApply" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "FlipFlopProfileDirectoryName" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "LockedRetryCount" -Value 3 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "LockedRetryInterval" -Value 15 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "ProfileType" -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "ReAttachIntervalSeconds" -Value 15 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "ReAttachRetryCount" -Value 3 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "SizeInMBs" -Value 30000 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "VolumeType" -Value "vhdx" -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "IgnoreNonWVD" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "IsDynamic" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "OutlookCachedMode" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "PreventLoginWithFailure" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "PreventLoginWithTempProfile" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "RemoveOrphanedOSTFilesOnLogoff" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "ConcurrentUserSessions" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;

    
    if((Test-Path -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC") -ne $true) {  New-Item "HKLM:\SOFTWARE\FSLogix\ODFC" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "Enabled" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "CCDLocations" -Value $ConnectionString -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeOneDrive" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeOneNote" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeOneNote_UWP" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeOutlook" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeOutlookPersonalization" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeSharepoint" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\FSLogix\ODFC" -Name "IncludeTeams" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;'


Out-File -FilePath .\fslogix-config.ps1 -InputObject $Script

try
{
    "Logging in to Azure..."
    Connect-AzAccount -EnvironmentName AzureUSGovernment -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

Import-Module Az.Compute

$MSHvms = Get-AzVM -ResourceGroupName $RGName
foreach ($mshvm in $MSHvms) {

$result = Invoke-AzVMRunCommand -ResourceGroupName $RGName -Name $mshvm.Name -CommandId 'RunPowerShellScript' -ScriptPath '.\fslogix-config.ps1'

$status = $result.value[0].message
write-output "Complete on $mshvm"
}