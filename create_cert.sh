#!/bin/bash

# version show
openssl version

# create encryption CA private key
openssl genrsa -aes128 -out ca.key 2048

# create CSR(certificate sign request)
# A challenge password: option label text filed, if not use -> just enter
openssl req -new -key ca.key -out ca.csr

# create self signed CA certificate by reference CSR
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt -days 365 -sha256

echo -e "\033[32m created CA certificate\033[0m"

# show crt file
openssl x509 -in ca.crt -text -noout

# create CA certificate by reference CSR
openssl x509 -req -in ca.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
     -out cas.crt -days 365 -sha256


