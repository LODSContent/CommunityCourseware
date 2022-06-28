Certutil -crl
robocopy %SYSTEMROOT%\system32\certsrv\CertEnroll d:\WebApps\Certdata *.crt *.crl /R:5 /W:5 /V /LOG+:%SYSTEMROOT%\logs\UpdateCrlLog.txt