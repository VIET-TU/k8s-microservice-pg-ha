#!/bin/bash

var_smbuser=${smbuser:-smbuser}
var_smbpassword=${password:-pass}
var_smbgroup="postgres"

if ! getent group $var_smbgroup >/dev/null; then
    groupadd $var_smbgroup
fi

if ! id -u $var_smbuser >/dev/null 2>&1; then
    useradd -g $var_smbgroup $var_smbuser
else
    usermod -a -G $var_smbgroup $var_smbuser
fi

(echo "$var_smbpassword"; echo "$var_smbpassword") | smbpasswd -s -a $var_smbuser

echo "user: $var_smbuser / group: $var_smbgroup"
echo "pass: $var_smbpassword"

for i in 0 1 2; do
    dir="/postgres-$i"
    mkdir -p "$dir"
    chmod 770 "$dir"
    chown -R $var_smbuser:$var_smbgroup "$dir"
done

if command -v systemctl >/dev/null; then
    service smbd start
    service nmbd start
else
    smbd --foreground --log-stdout 
fi
