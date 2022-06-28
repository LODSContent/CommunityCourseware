Certutil -crl delta
robocopy %SYSTEMROOT%\system32\certsrv\CertEnroll d:\WebApps\Certdata *+.crl /R:5 /W:5 /V /LOG+:%SYSTEMROOT%\logs\UpdateDeltaCrlLog.txt