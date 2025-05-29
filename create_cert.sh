#!/bin/bash

# version show
openssl version

# CA Cert
echo -e "\033[34m CA Certificate Make\033[0m"

# create encryption CA private key
openssl genrsa -out CA/ca.key 2048

# create CA CSR(certificate signing request)
# A challenge password: option label text filed, if not use -> just enter
openssl req -new -key CA/ca.key -out CA/ca.csr

# create self signed CA certificate by reference CA CSR
openssl x509 -req -in CA/ca.csr -signkey CA/ca.key -out CA/ca.crt -days 365 -sha256

echo -e "\033[32m created CA certificate\033[0m"

# show crt file
openssl x509 -in CA/ca.crt -text -noout

# Server Cert
echo -e "\033[34m Server Certificate Make\033[0m"

# create encryption server private key
openssl genrsa -out server/server.key 2048

# create server CSR(certificate signing request)
openssl req -new -key server/server.key -out server/server.csr

# create CA signed server certificate by reference server CSR
openssl x509 -req -days 365 -in server/server.csr -CA CA/ca.crt -CAkey CA/ca.key -CAcreateserial -out server/server.crt -sha256

echo -e "\033[32m created Server certificate\033[0m"

# Client Cert
echo -e "\033[34m Client Certificate Make\033[0m"

# create encryption client private key
openssl genrsa -out client/client.key 2048

# create client CSR(certificate signing request)
openssl req -new -key client/client.key -out client/client.csr

# create CA signed client certificate by reference server CSR
openssl x509 -req -days 365 -in client/client.csr -CA CA/ca.crt -CAkey CA/ca.key -CAcreateserial -out client/client.crt -sha256

echo -e "\033[32m created Client certificate\033[0m"







