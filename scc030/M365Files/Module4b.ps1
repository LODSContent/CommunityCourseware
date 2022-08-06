Param (
[Parameter(Mandatory=$true)] [string]$Username,
[Parameter(Mandatory=$true)] [string]$Password,
[Parameter(Mandatory=$true)] [string]$ID
)

$pwd = ConvertTo-SecureString "$Password" -asPlainText -Force

$cred = new-object System.Management.Automation.PSCredential($username,$pwd)

Connect-AzureAD -credential $cred | out-null
Connect-mgGraph -scopes Files.Read, Files.Read.All, Sites.Read.All -contextscope CurrentUser
$files =  Try {invoke-mggraphrequest -uri "v1.0/me/drive/root/children" -erroraction ignore} Catch {}
$names = $files.Values.name
$content = $ID,$names
set-content -path c:\verifyitems\files.txt -value $content

write-host "The script has completed. Thank you!"
