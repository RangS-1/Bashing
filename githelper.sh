#!/bin/bash

check_branch(){
    BRANCH=$(git branch --show-current)
    printf "[!] You are on $BRANCH branch!"
}

stages(){
    ONSTAGES=$(git diff --name-only --staged .)
    echo
    echo "[!] File in stages Area:"
    echo "[!] $ONSTAGES"
    echo
    echo "[1] Back" 
    read -p "[!] File to Staged: " STAGE
    if [[ "$STAGE" == "1" ]]; then
        show_menu
    else
        git add "$STAGE"
        git status | grep "modified"
    fi
}

unstages(){
    ONSTAGES=$(git diff --name-only --staged .)
    echo
    echo "[!] File in stages Area:"
    echo "[!] $ONSTAGES"
    echo
    echo "[1] Back" 
    read -p "[!] File to Unstaged: " STAGE
    if [[ "$STAGE" == "1" ]]; then
        show_menu
    else
        git restore --staged "$STAGE"
        git status | grep "modified"
    fi
}

commit(){
    ONSTAGES=$(git diff --name-only --staged .)
    echo
    echo "[!] File in stages Area:"
    echo "[!] $ONSTAGES"
    echo
    echo "[1] Back"
    read -p "[!] Commit Message: " COMMIT
    if [[ "$COMMIT" == "1" ]]; then
        show_menu
    else
        git commit -m "$COMMIT"
    fi
}

branch(){
    BRANCH=$(git branch --show-current)
    echo
    echo "[!] You are on $BRANCH branch!"
    echo "[1] Back              [3] Create Branch"
    echo "[2] Change Branch     [4] Create and Change Branch"
    read -p "[!] Your Choice: " BRANCHING
    if [[ "$BRANCHING" == "1" ]]; then
        show_menu
    elif [[ "$BRANCHING" == "2" ]]; then
        read -p "[!] Branch Name: " BRANCHNAME
        git switch "$BRANCHNAME"
        show_menu
    elif [[ "$BRANCHING" == "3" ]]; then
        read -p "[!] Branch Name: " BRANCHNAME
        git branch "$BRANCHNAME"
        show_menu
    elif [[ "$BRANCHING" == "4" ]]; then
        read -p "[!] Branch Name: " BRANCHNAME
        git checkout -b "$BRANCHNAME"
        show_menu
    else
        echo "[!] Please Choose"
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
    echo "[1] Auto Push         [5] Branch    [9] Exit"
    echo "[2] Staged Files      [6] Push"
    echo "[3] Unstaged Files    [7] Merge"
    echo "[4] Commit            [8] Clear"
    read -p "[!] Your Choice: " SELECT
    case "$SELECT" in
        "1")

            ;;
        "2")
            stages
            show_menu
            ;;
        "3")
            unstages
            show_menu
            ;;
        "4")
            commit
            show_menu
            ;;
        "5")
            branch
            show_menu
            ;;
        "6")
            
            ;;
        "7")
            
            ;;
        "8")
            clear
            show_menu
            ;;
        "9")
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