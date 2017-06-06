winrm delete winrm/config/Listener?Address=*+Transport=HTTPS

winrm create winrm/config/Listener?Address=*+Transport=HTTPS '@{Hostname="wonderland.local"; CertificateThumbprint="f0ead08369f48c1bbdbf46cc4adebfacea7f2609"}'

winrm enumerate winrm/config/listener
