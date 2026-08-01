#!/bin/env bash

check_user(){
    echo -e "\e[35m=================\e[0m"
    echo -e "\e[35m==\e[0m \e[31mUser Killer\e[0m \e[35m==\e[0m"
    echo -e "\e[35m=================\e[0m"
    awk -F':' '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd
}

kill_user(){
    printf "\e[35m[!]\e[0m"
    read -p " Choose user you want to Kill: " USERNAME
    printf "\e[35m[!]\e[0m"
    read -p " Are you sure want to kill $USERNAME(Y/n)?" CHOICE
    if [[ "$CHOICE" == "Y" || "$CHOICE" == "y" ]]; then
        sudo userdel -r "$USERNAME"
        echo -e "\e[32m[✓] User $USERNAME has been killed.\e[0m"
    elif [[ "$CHOICE" == "N" || "$CHOICE" == "n" ]]; then
        echo -e "\e[31m[X] Operation Cancelled.\e[0m"
    else
        kill_user
    fi
}

start(){
    check_user
    kill_user
}

start