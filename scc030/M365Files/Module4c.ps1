Param (
[Parameter(Mandatory=$true)] [string]$Username,
[Parameter(Mandatory=$true)] [string]$Password,
[Parameter(Mandatory=$true)] [string]$ID
)

$result = $false
$pwd = ConvertTo-SecureString "$Password" -asPlainText -Force

$cred = new-object System.Management.Automation.PSCredential($username,$pwd)

Connect-AzureAD -credential $cred | out-null
Connect-mgGraph -scopes DeviceManagementApps.Read.All -contextscope CurrentUser


$result  = $false
Select-MgProfile -Name beta

$IntApp = Try {Get-MgDeviceAppMgtMobileApp | where displayname -like "Microsoft 365 Apps for Win*"} Catch {$null}

If (!$intapp) {$result = $false}

ElseIf ($intapp.AdditionalProperties.excludedApps.oneNote -eq $True -and 
$intapp.AdditionalProperties.excludedApps.publisher -eq $true) {
    $result = $true
    $content = $ID, $result
    set-content -Path C:\verifyitems\activity.txt $content
# $scoresum += 1}
}

# results
# Set-LabVariable -Name r3 $scoresum
# $result
write-host "The script has completed. Thank you!"