#!/bin/bash

sslConf="\
[req]
prompt = no
distinguished_name = dn
x509_extensions = v3_req

[dn]                                  # Distinguished Name 憑證的相關資訊
CN = ٩(๑❛ᴗ❛๑)۶.y.es 💻乖乖椰子👌   # Common Name 憑證名稱

[v3_req]
subjectAltName = @alt_names

[alt_names]                           # 設定 SSL 憑證的域名
DNS.1 = localhost
DNS.2 = y.es               # 不可被註冊的域名
DNS.3 = *.y.es
DNS.4 = *.dev.y.es
DNS.5 = sup6cl3.bt         # 可被註冊的域名
DNS.6 = *.sup6cl3.bt
DNS.7 = *.dev.sup6cl3.bt
"


if ! type openssl &> /dev/null ; then
  echo "Not found "openssl" command."
  exit 1
fi

certName="kuaiYs"
( sed 's/ *\(#.*\)$//g' |
  openssl req -x509 -new -nodes -sha256 -utf8 -days $[365 * 99] -newkey rsa:2048 -keyout $certName.key -out $certName.crt -config -
) <<< "$sslConf"
openssl pkcs12 -export -in $certName.crt -inkey $certName.key -out $certName.pfx

