# WONDERLAND ROOT CA  = AnnaHas3ApplesButJoeHas~100
# WONDERLAND INT CA   = The2ndKingIsStillDead!LongLiveTheNewKing!
# WONDERLAND          = HelloGeorgeThe3rd!LongTimeNoSee!
# Pfx Export Password = IHad2Cents,ButNowIveGot100More!

# GB ; England ; London ; WONDERLAND, Inc. ; WONDERLAND ROOT CA
\OpenSSL-Win64\bin\openssl genrsa -des3 -out ca.key 1024
\OpenSSL-Win64\bin\openssl req -new -x509 -days 3652 -key ca.key -out ca.crt
\OpenSSL-Win64\bin\openssl x509 -in ca.crt -out ca.pem
# \OpenSSL-Win64\bin\openssl pkcs12 -export -out ca.pfx -inkey ca.key -in ca.crt
# \OpenSSL-Win64\bin\openssl genrsa -des3 -out ca-int_encrypted.key 1024
\OpenSSL-Win64\bin\openssl genrsa -des3 -out ca-int.key 1024
\OpenSSL-Win64\bin\openssl req -config config.cfg -new -key ca-int.key -out ca-int.csr -subj "/CN=WONDERLAND INT CA" -extensions ext1
\OpenSSL-Win64\bin\openssl x509 -extfile config.cfg -req -days 3652 -in ca-int.csr -CA ca.crt -CAkey ca.key -set_serial 1001 -out ca-int.crt -extensions ext1
# \OpenSSL-Win64\bin\openssl pkcs12 -export -out ca-int.pfx -inkey ca-int.key -in ca-int.crt
# \OpenSSL-Win64\bin\openssl rsa -in server_encrypted.key -out server.key
\OpenSSL-Win64\bin\openssl genrsa -des3 -out server_encrypted.key 1024
\OpenSSL-Win64\bin\openssl rsa -in server_encrypted.key -out server.key
\OpenSSL-Win64\bin\openssl req -config config.cfg -new -key server.key -out server.csr -subj "/CN=wonderland.local" -extensions ext2
\OpenSSL-Win64\bin\openssl x509 -extfile config.cfg -req -days 3652 -in server.csr -CA ca-int.crt -CAkey ca-int.key -set_serial 1001 -out server.crt -extensions ext2
\OpenSSL-Win64\bin\openssl pkcs12 -export -out server.pfx -inkey server.key -in server.crt
