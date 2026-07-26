#!/bin/bash

check_branch(){
    BRANCH=$(git branch --show-current)
    printf "[!] You are on $BRANCH branch!"
}

stages(){
    echo
    echo "[1] Back" 
    read -p "[!] File to Staged Area: " STAGE
    if [[ "$STAGE" == "1" ]]; then
        show_menu
    else
        git add "$STAGE"
        git status
    fi
}

commit(){
    echo
    echo "[1] Back" 
    read -p "[!] Commit Message: " COMMIT
    if [[ "$COMMIT" == "1" ]]; then
        show_menu
    else
        git commit -m "$COMMIT"
    fi
}

show_menu(){
    echo "========================"
    echo "== Git Project Helper =="
    echo "========================"
    check_branch
    echo
    echo "[!] Please select task!"
    echo
    echo "[1] Auto Push"
    echo "[2] Stages Area"
    echo "[3] Commit"
    echo "[4] Clean Journal"
    echo "[5] Remove Old Downloads"
    echo "[6] Disk Usage"
    echo "[7] Clear Screen"
    echo "[8] Exit"
    read -p "[!] Your Choice: " SELECT

    case "$SELECT" in
        "1")

            ;;
        "2")
            stages
            show_menu
            ;;
        "3")
            commit
            show_menu
            ;;
        "4")
            
            ;;
        "5")
            
            ;;
        "6")
            
            ;;
        "7")
            
            ;;
        "8")
            echo
            echo "[✓] OK! See Ya!"
            exit 1
            ;;
        *)
            show_menu
            ;;
    esac
}

show_menu