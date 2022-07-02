# Create OUs.

New-ADOrganizationalUnit -Name Corp -Path 'DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name Users -Path 'OU=Corp,DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name UserGroups -Path 'OU=Corp,DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name Computers -Path 'OU=Corp,DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name AdminGroups -Path 'OU=Corp,DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name PKI -Path 'OU=AdminGroups,OU=Corp,DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name PKIServers -Path 'OU=Computers,OU=Corp,DC=Hexelo,DC=COM'
New-ADOrganizationalUnit -Name ComputerGroups -Path 'OU=Corp,DC=Hexelo,DC=COM'

# Create users from csv file
Import-Csv D:\LabFiles\Scripts\users.csv | foreach {New-AdUser -Name "$($_.DisplayName)" -SAMAccountName ($_.SAM) -UserPrincipalName ($_.SAM + "@Hexelo.com") -EmailAddress ($_.SAM + "@Hexelo.com")  -DisplayName "$($_.DisplayName)" -GivenName "$($_.Fname)" -Surname "$($_.Lname)" -AccountPassword (ConvertTo-SecureString -AsPlainText "Passw0rd!" -Force)  -PasswordNeverExpires $true -Path 'OU=Users,OU=Corp,DC=Hexelo,DC=com'}  

# Enable all accounts created in the Users OU
Get-ADUser -Filter * -SearchBase "OU=Users,OU=Corp,DC=Hexelo,DC=com" | Where-Object{$_.Enabled -like "False"} | Enable-AdAccount

#Create PKI groups and add members

dsadd group "cn=CA-Admins,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Administering CA" -members "cn=CAAdmin1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=CAAdmin2,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=svcPKITasks,ou=Users,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=Cert-Managers,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Certificate Administration" -members "cn=CertManager1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=CertManager2,ou=Users,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=Cert-Template-Admins,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Certificate Template Administration" -members "cn=CertTemplateMgr1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=CertTemplateMgr2,ou=Users,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=Cert-Auditors,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for CA Auditing" -members "cn=CAAuditor1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=CAAuditor2,ou=Users,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=Cert-Backup-Operators,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Backing up CA" -members "cn=CABackup1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=CABackup2,ou=Users,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=Key-Recovery-Agents,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Key Recovery Agents" -members "cn=KRA1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=KRA2,ou=Users,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=CRLPublisher,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for users who can copy CRLs and AIA to CDP locations" -members "cn=CA-Admins,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=PKIAdmins,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for all CA and Certificate Admins" -members "cn=CA-Admins,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" "cn=Cert-Managers,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" "cn=Cert-Template-Admins,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" "cn=Cert-Auditors,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" "cn=Cert-Backup-Operators,ou=pki,ou=AdminGroups,ou=corp,dc=hexelo,dc=com"

dsadd group "cn=WebAdmins,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Web Admins" -members "cn=WebAdmin1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=WebAdmin2,ou=Users,ou=corp,dc=hexelo,dc=com" 

dsadd group "cn=PKIUsers,ou=UserGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for PKI Users" -members "cn=PKIUser1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=PKIUser2,ou=Users,ou=corp,dc=hexelo,dc=com" 

dsadd group "cn=CodeSigners,ou=AdminGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Code Signers" -members "cn=Dev1,ou=Users,ou=corp,dc=hexelo,dc=com" "cn=Dev2,ou=Users,ou=corp,dc=hexelo,dc=com" 

dsadd group "cn=WebServers,ou=ComputerGroups,ou=corp,dc=hexelo,dc=com" -scope g -desc "Group for Web Servers" -members "cn=WIN-SRV22-001$,cn=Computers,dc=hexelo,dc=com" 
