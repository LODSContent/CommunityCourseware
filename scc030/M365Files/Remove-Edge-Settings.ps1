#Variables
$OMADMPath = 'HKLM:SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'
$EnrollmentPath = 'HKLM:SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'
$EdgePath = 'HKLM:SOFTWARE\Policies\Microsoft\Edge'

## Removal
Remove-Item -Path $EnrollmentPath
Remove-Item -Path $OMADMPath
Remove-ItemProperty -Path $EdgePath -Name NewTabPageAllowedBackgroundTypes 
Remove-ItemProperty -Path $EdgePath -Name HomePageLocation 
Remove-ItemProperty -Path $EdgePath -Name NewTabPageLocation
Remove-ItemProperty -Path $EdgePath -Name NewTabPageContentEnabled
Remove-ItemProperty -Path $EdgePath -Name NewTabPageHideDefaultTopSites
Remove-ItemProperty -Path $EdgePath -Name ClearBrowsingDataOnExit
Remove-ItemProperty -Path $EdgePath -Name FavoritesBarEnabled
Restart-Computer