#!/bin/bash

echo "=============="
echo "== New User =="
echo "=============="

if [[ $EUID -ne 0 ]]; then
    echo "Error: Sudo is needed!"
    exit 1
fi

create_user(){
    read -p "[!] Username: " USERNAME

    if [[ "$USERNAME" == "" ]]; then
        echo "[!] Cannot Empty!"
        create_user
    else
        useradd -m -G wheel -s /bin/bash "$USERNAME"
        passwd "$USERNAME"
    fi
}

create_user