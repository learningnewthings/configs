


# openssl verify -untrusted ca-bundle cert.pem

# New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My\ -DnsName "WONDERLAND CA"
# !!! Copy the Thumbprint ie. 7D3CC04CDCBFCEC10900504E0582858A90AD0722
# $pwd = ConvertTo-SecureString -String "AnnaHas3ApplesButJoeHas~100" -Force -AsPlainText
# Export-PfxCertificate -Cert Cert:\LocalMachine\My\7D3CC04CDCBFCEC10900504E0582858A90AD0722 -FilePath root-authority.pfx -Password $pwd
# $rootcert = ( Get-ChildItem -Path Cert:\LocalMachine\My\7D3CC04CDCBFCEC10900504E0582858A90AD0722 )
# New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My\ -DnsName "WONDERLAND" -Signer $rootcert
# !!! Copy the Thumbprint ie. ‎8fcf0446a0cc2202064f67f8fb35ea25bd3ee237
# $pwd2 = ConvertTo-SecureString -String "The2ndKingIsStillDead!LongLiveTheNewKing!" -Force -AsPlainText
# Export-PfxCertificate -Cert Cert:\LocalMachine\My\‎8fcf0446a0cc2202064f67f8fb35ea25bd3ee237 -FilePath gateway-certificate.pfx -Password $pwd2

# winrm set winrm/config/client/auth '@{Basic="false"}'
# winrm quickconfig
# net stop winrm
# winrm enumerate winrm/config/listener
# winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
# winrm get winrm/config
# winrm set winrm/config/service '@{CertificateThumbprint="‎8fcf0446a0cc2202064f67f8fb35ea25bd3ee237"}'
# Get-NetConnectionProfile
# Set-NetConnectionProfile -NetworkCategory Private
# winrm create winrm/config/Listener?Address=*+Transport=HTTPS '@{Hostname="wonderland.local"; CertificateThumbprint="c5bce8e743bf1ae4ce53f5712bec37c426f246eb"}'

# /usr/share/ca-certificates/mozilla
# /usr/local/share/ca-certificates
# /etc/ssl/certs
# /etc/ssl/private




# download new WP
# remove default themes
# put UBT theme
# remove defaul plugins
# put necesarry plugins
# install the database
# open the webserver

# GUIDELINE:
# modify ACF on local, export fields from local, import them on online, populate them online , backup the online database, import it on localhost.


# course plugin, uploads, databases

