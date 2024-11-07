#!/bin/bash

# 不存在的頂級域名不被 Edge 接受

# 計算天數
today=$(date +%s)
theDay=$(date -u -d "2092-02-11" +%s)
daysLeft=$[(theDay - today) / 86400 + 1]
# daysLeft=$[365 * 99 + 1]

sslConf="\
[req]
prompt          = no
default_bits    = 2048
default_md      = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]                                  # Distinguished Name 憑證的相關資訊
O  = (ㄏ￣▽￣)ㄏ ㄟ(￣▽￣ㄟ)       # 組織名稱 (Organization)
CN = ٩(๑❛ᴗ❛๑)۶.y.es 💻乖乖椰子👌   # Common Name 憑證名稱

[v3_req]
subjectAltName = @alt_names

[alt_names]                           # 設定 SSL 憑證的域名
DNS.1 = localhost
DNS.2 = y.es                       # 不能註冊, 紀念初衷
DNS.3 = dock.er
DNS.4 = *.dock.er
DNS.5 = do.it
DNS.6 = *.do.it
"

if ! type openssl &> /dev/null ; then
  echo "Not found "openssl" command."
  exit 1
fi

certName="kuaiYs"
( sed 's/ *\(#.*\)$//g' |
  openssl req -x509 -new -nodes -utf8 -days $daysLeft -config - \
    -keyout $certName.key -out $certName.crt
) <<< "$sslConf"

# 查看 .crt 資訊
openssl x509 -in $certName.crt -text -noout

# 用不到?
# openssl pkcs12 -export -in $certName.crt -inkey $certName.key -out $certName.pfx
