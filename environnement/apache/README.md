

```
mkdir ./config/certificat
```

```
keytool -genkeypair -alias cas -keyalg RSA -keypass changeit -storepass changeit -keystore ./config/certificat/keystore -dname ${DNAME:-CN=dev-app,OU=dev-app,C=dev-app}
```
```
keytool -list -v -keystore ./config/certificat/keystore -storepass changeit 
```
```
keytool -importkeystore -srckeystore ./config/certificat/keystore -storepass changeit -destkeystore ./config/certificat/keystore -deststoretype pkcs12
```
```
keytool -importkeystore -srckeystore ./config/certificat/keystore -storepass changeit -destkeystore ./config/certificat/output2.p12 -deststoretype PKCS12
```

```
openssl pkcs12 -in ./config/certificat/output2.p12 -passin pass:changeit -nodes -out ./config/certificat/temporary.pem 
```
```
sed -n '/^-----BEGIN PRIVATE KEY-----/,/^-----END PRIVATE KEY-----/p' ./config/certificat/temporary.pem > ./config/private.key
```
```
sed -n '/^-----BEGIN CERTIFICATE-----/,/^-----END CERTIFICATE-----/p' ./config/certificat/temporary.pem > ./config/certificate.pem

```