# BEGIN SCRIPT

# BEGIN EDITABLE
# SET OPENSSL PATHS TO BIN DIR AND CONFIG FILE
$OPENSSL_PATH		= "\OpenSSL-Win64\bin\openssl.exe"
$OPENSSL_CNF_PATH	= ".\SSLConfig.cfg"
# SET P455W0RD5
$ROOT_CA_P455W0RD	= "AnnaHas3ApplesButJoeHas~100"
$ROOT_CA_PFX_P455W0RD	= "BuyNow!The93WaysForBetterComprehension"
$INT_CA_P455W0RD	= "The2ndKingIsStillDead!LongLiveTheNewKing!"
$INT_CA_PFX_P455W0RD	= "ImMad@TheUniversForMakingThe2OfYouSmarter."
$SERVER_P455W0RD	= "HelloHenryThe3rd!LongTimeNoSee!"
$SERVER_PFX_P455W0RD	= "IHad2Cents,HowDidIget300More?"
# SET EXPIRATION => No OF DAYS
$ROOT_CA_EXPIRATION	= 3652
$INT_CA_EXPIRATION	= 3652
$SERVER_EXPIRATION	= 3652
# SET CERTIFICATES PATH
$ROOT_CA_CERT_PATH	= ".\ROOT CA CERTS"
$INT_CA_CERT_PATH	= ".\INT CA CERTS"
$SERVER_CERT_PATH	= ".\SERVER CERTS"
# SET CERTIFICATES NAME
$ROOT_CA_CERT_NAME	= "\wonderland-root-ca"
$INT_CA_CERT_NAME	= "\wonderland-int-ca"
$SERVER_CERT_NAME	= "\wonderland.local"
# ADDITIONAL CERTIFICATES SETTINGS
$ROOT_CA_SUBJECT	= "/L=London/ST=England/C=GB/O=WONDERLAND, Inc./CN=WONDERLAND ROOT CA"
$INT_CA_SUBJECT		= "/L=London/ST=England/C=GB/O=WONDERLAND, Inc./CN=WONDERLAND INT CA"
$SERVER_SUBJECT		= "/L=London/ST=England/C=GB/O=WONDERLAND, Inc./CN=wonderland.local"
$INT_CA_SERIAL		= 1005
$SERVER_SERIAL		= 1005
# END EDITABLE

& mkdir $ROOT_CA_CERT_PATH
& mkdir $INT_CA_CERT_PATH
& mkdir $SERVER_CERT_PATH

$ROOT_CA_PATH_AND_NAME	= $ROOT_CA_CERT_PATH + $ROOT_CA_CERT_NAME
$INT_CA_PATH_AND_NAME	= $INT_CA_CERT_PATH + $INT_CA_CERT_NAME
$SERVER_PATH_AND_NAME	= $SERVER_CERT_PATH + $SERVER_CERT_NAME

& $OPENSSL_PATH genrsa -des3 -passout pass:$ROOT_CA_P455W0RD -out "$($ROOT_CA_PATH_AND_NAME).key" 1024
& $OPENSSL_PATH req -config $OPENSSL_CNF_PATH -new -x509 -days $ROOT_CA_EXPIRATION -passin pass:$ROOT_CA_P455W0RD -key "$($ROOT_CA_PATH_AND_NAME).key" -out "$($ROOT_CA_PATH_AND_NAME).crt" -subj $ROOT_CA_SUBJECT -extensions ext1
& $OPENSSL_PATH x509 -in "$($ROOT_CA_PATH_AND_NAME).crt" -out "$($ROOT_CA_PATH_AND_NAME).pem"
& $OPENSSL_PATH pkcs12 -password pass:$ROOT_CA_PFX_P455W0RD -export -out "$($ROOT_CA_PATH_AND_NAME).pfx" -passin pass:$ROOT_CA_P455W0RD -inkey "$($ROOT_CA_PATH_AND_NAME).key" -in "$($ROOT_CA_PATH_AND_NAME).crt"

& $OPENSSL_PATH genrsa -des3 -passout pass:$INT_CA_P455W0RD -out "$($INT_CA_PATH_AND_NAME).key" 1024
& $OPENSSL_PATH req -config $OPENSSL_CNF_PATH -new -passin pass:$INT_CA_P455W0RD -key "$($INT_CA_PATH_AND_NAME).key" -out "$($INT_CA_PATH_AND_NAME).csr" -subj $INT_CA_SUBJECT -extensions ext2
& $OPENSSL_PATH x509 -extfile $OPENSSL_CNF_PATH -req -days $INT_CA_EXPIRATION -in "$($INT_CA_PATH_AND_NAME).csr" -passin pass:$ROOT_CA_P455W0RD -CA "$($ROOT_CA_PATH_AND_NAME).crt" -CAkey "$($ROOT_CA_PATH_AND_NAME).key" -set_serial $INT_CA_SERIAL -out "$($INT_CA_PATH_AND_NAME).crt" -extensions ext2
& $OPENSSL_PATH x509 -in "$($INT_CA_PATH_AND_NAME).crt" -out "$($INT_CA_PATH_AND_NAME).pem"
& $OPENSSL_PATH pkcs12 -password pass:$INT_CA_PFX_P455W0RD -export -out "$($INT_CA_PATH_AND_NAME).pfx" -passin pass:$INT_CA_P455W0RD -inkey "$($INT_CA_PATH_AND_NAME).key" -in "$($INT_CA_PATH_AND_NAME).crt"

& $OPENSSL_PATH genrsa -des3 -passout pass:$SERVER_P455W0RD -out "$($SERVER_PATH_AND_NAME).key" 1024
& $OPENSSL_PATH rsa -passin pass:$SERVER_P455W0RD -in "$($SERVER_PATH_AND_NAME).key" -out "$($SERVER_PATH_AND_NAME).key"
& $OPENSSL_PATH req -config $OPENSSL_CNF_PATH -new -key "$($SERVER_PATH_AND_NAME).key" -out "$($SERVER_PATH_AND_NAME).csr" -subj $SERVER_SUBJECT -extensions ext3
& $OPENSSL_PATH x509 -extfile $OPENSSL_CNF_PATH -req -days $SERVER_EXPIRATION -in "$($SERVER_PATH_AND_NAME).csr" -passin pass:$INT_CA_P455W0RD -CA "$($INT_CA_PATH_AND_NAME).crt" -CAkey "$($INT_CA_PATH_AND_NAME).key" -set_serial $SERVER_SERIAL -out "$($SERVER_PATH_AND_NAME).crt" -extensions ext3
& $OPENSSL_PATH x509 -in "$($SERVER_PATH_AND_NAME).crt" -out "$($SERVER_PATH_AND_NAME).pem"
& $OPENSSL_PATH pkcs12 -password pass:$SERVER_PFX_P455W0RD -export -out "$($SERVER_PATH_AND_NAME).pfx" -inkey "$($SERVER_PATH_AND_NAME).key" -in "$($SERVER_PATH_AND_NAME).crt"

# END SCRIPT
