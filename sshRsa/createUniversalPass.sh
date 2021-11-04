#!/bin/bash
# 創建通用金鑰


fnSh_createSshKey() {
  opt_pubRsa=""
  opt_rsa=""
  opt_home=0
  opt_createKey=0
  opt_name=""

  while [ -n "y" ]
  do
    case "$1" in
      --name )
        opt_name=$2
        shift 2
        ;;
      --pubRsa )
        opt_pubRsa=$2
        shift 2
        ;;
      --rsa )
        opt_rsa=$2
        shift 2
        ;;
      -H | --home )
        opt_home=1
        shift
        ;;
      -C | --create-key )
        opt_createKey=1
        shift 1
        ;;
      * ) break ;;
    esac
  done

  local keyDirPathArgu="$1"

  local isHome=0
  if [ $opt_home -eq 1 ] && [ -n "$keyDirPathArgu" ]; then
    isHome=1
  fi

  local keyDirPath="$keyDirPathArgu"
  if [ -z "$keyDirPath" ]; then
    keyDirPath="$PWD"
  elif [ $isHome -eq 1 ]; then
    keyDirPath="$keyDirPath/.ssh"
  fi

  [ -d "$keyDirPath" ] || mkdir -p "$keyDirPath"

  if [ $isHome -eq 1 ]; then
    chmod 700 "$keyDirPath"

    echo "$opt_pubRsa" > "$keyDirPath/authorized_keys"
    chmod 600            "$keyDirPath/authorized_keys"
  fi

  local name="vmpass"
  if [ "$opt_createKey" -eq 1 ]; then
    [ -z "$opt_name" ] || name="$opt_name"

    echo "$opt_pubRsa" > "$keyDirPath/${name}_rsa.pub"
    chmod 644            "$keyDirPath/${name}_rsa.pub"

    echo -e "$opt_rsa" > "$keyDirPath/${name}_rsa"
    chmod 600            "$keyDirPath/${name}_rsa"
  fi
}


fnSh_createSshKey --name "universal-pass" \
--pubRsa \
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvvVrt53imj9Xg4InTdnlS7FYpGNWhQ+V5DUpc6r3Lzyivrs81jzyTt+13R7mQPv8ClBiyITCkQ63hxHoJaG9eZ5BF6vaKtRrYydqTkSNZfWBKV/QJHO729ujEKktf6zbVbVUzzSZ9lbQpk9vqAWWoYCvemBzkLXmnL2rLxafI5GYZ5z9gp0qP73euAq4Id1CCv/T9xCFC4FnrOpGJp4qMiQNhinDEdWKTDzQdtwQUoKfjh8IB6rALuV7zwAfeOqFIeVh4TNbyefI2DfJ2o8qKOpHyrQO7GjODl9qGGskNn1BpQ6J6PO+fc4l1GvJRBnUf34LHWzEwwuu23ZNGo/Dx root@vmpass" \
--rsa \
"-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAr71a7ed4po/V4OCJ03Z5UuxWKRjVoUPleQ1KXOq9y88or67P
NY88k7ftd0e5kD7/ApQYsiEwpEOt4cR6CWhvXmeQRer2irUa2Mnak5EjWX1gSlf0
CRzu9vboxCpLX+s21W1VM80mfZW0KZPb6gFlqGAr3pgc5C15py9qy8WnyORmGec/
YKdKj+93rgKuCHdQgr/0/cQhQuBZ6zqRiaeKjIkDYYpwxHVikw80HbcEFKCn44fC
AeqwC7le88AH3jqhSHlYeEzW8nnyNg3ydqPKijqR8q0Duxozg5fahhrJDZ9QaUOi
ejzvn3OJdRryUQZ1H9+Cx1sxMMLrtt2TRqPw8QIDAQABAoIBAFkYvSLkOYzoW1y5
OecVp4jc/Qm054ns7Egk7tCQykyr6Eq5a6AR0Hprw1635GI3Lf5WqvaUUR7WmS9e
9ygR5HSOONzZtMi57LSAEerCqJNUNx853CVKn/RhVb0uXCxzCcfGuG2c0qjU3xQ9
PD81Gh71MwiVQgCE9apHJfPNb7UvDxup8i/cVagHeimM2HrUXnsNfCPguza/hIa8
Em8ZIhalxZ28F+0o1ZCBaeD6AUU4spZltXfKAE5NniXSwMDzlPjhaXerisqNp3IH
9B76c2l4SQtAPSEBags0NdpNTSb+hkTE5BXpsWkUDqUe3kajwIIe0MoB/9rsRgNH
ZlLDgGECgYEA377KlxYOs2C7wHMtoqTFvkU/KdkNxd8KrScN+/mumjjR6ddwZ/6H
rEG4UoaJxdGeMHEGVgEDb6dlPePAsnHueCRLQay+k2YVG3luQY5kQRpFMRZEMiQ0
EZk9TiOe2rlX8FEE5oAlBqFoTBJzhQ5cDIJiYLQsdRQ6vAJj6cinJ5UCgYEAyRLw
yY/vcWG8oPR6wmGTc2UHbv+xFBf7nnLmMxIMYGch5txsD/HDWHZ8A/NzTxBvfbnZ
jPAQkGGCXrSMvkmrZIq2cjJYcy3GgUcJoYlh1e5phEaeObvFHfNOAyCVbDVG8xeu
bplagBPmGtABIX6/X08LLAXwiuq2MTf0YylQHO0CgYEAv+KzgiGTl/j07BabY6om
QIjIo84XhsRDNr6QurGmMXNba02thDKBDpUKTBQ/4dxk6yxzf5y84qvQIuTJZQBa
wMR3mipZAraAkaBxk11X05GBF5j+AXaVBSbDsdjQqspbhakmJ7xshKQ2e08zrT/k
Z4IGduLuYbZorMbsAxpnaIUCgYAa267SHanMKVP64+0p3cLGXS5bA0hx+KohhhN9
quGAVwZOQg8lKhP/0wPJu1EhtH5P+u02SDLONlglslRCbrC4I1cvdc4exHSJfCWr
MCCjZM8vXgdwisZPs9otzMJoy80IV5dzKoTOKtpHppUgFkAVyQcjAEAbLjLb7C92
t2P+GQKBgBfE2/BMEaYVpu60iPW4FK9GmrMfQSKx5MDzFFuoHXWPMiZUdbFguh62
+Vrf3QVNC0UIwfNsSSev9+ZCtJzgWwHFiAWsuler3cviOhBP0BQ4/RACjEA6b0Uz
te0j/DR7eFOBG5JNeB8SfQKAtS+p+Y93WQGEtSPyx4pz+Hiit/Ek
-----END RSA PRIVATE KEY-----" \
"$@"

