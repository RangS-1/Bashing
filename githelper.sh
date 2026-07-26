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

merge(){
    BRANCH=$(git branch --show-current)
    echo
    echo "[!] You are on $BRANCH branch!"
    echo "[1] Back              [3] Change to Master"
    echo "[2] Change to main    [4] Merge to Main"
    read -p "[!] Your Choice: " MERGING
    if [[ "$MERGING" == "1" ]]; then
        show_menu
    elif [[ "$MERGING" == "2" ]]; then
        git branch -M main
        merge
    elif [[ "$MERGING" == "3" ]]; then
        git branch -M main
        merge
    elif [[ "$MERGING" == "4" ]]; then
        read -p "[!] Branch Name: " MERGING
        git merge "$MERGING"
        show_menu
    else
        echo "[!] Please Choose"
    fi
}

pulling(){
    git pull origin main
}

pushing(){
    BRANCH=$(git branch --show-current)
    echo
    echo "[!] You are on $BRANCH branch!"
    echo "[1] Back"
    echo "[2] Push"
    read -p "[!] Your Choice: " PUSHING
    if [[ "$PUSHING" == "1" ]]; then
        show_menu
    elif [[ "$PUSHING" == "2" ]]; then
        git push -u origin main
        show_menu
    else
        echo "[!] Please Choose"
        pushing
    fi
}

remote(){
    BRANCH=$(git branch --show-current)
    echo
    echo "[!] You are on $BRANCH branch!"
    echo "[1] Back          [3] Set URL"
    echo "[2] New Remote"
    read -p "[!] Your Choice: " REMOTES
    if [[ "$REMOTES" == "1" ]]; then
        show_menu
    elif [[ "$REMOTES" == "2" ]]; then
        read -p "[!] URL: " URL
        git remote add origin "$URL"
        show_menu
    elif [[ "$REMOTES" == "3" ]]; then
        read -p "[!] URL: " URL
        git remote set-url origin "$URL"
        show_menu
    else
        echo "[!] Please Choose"
        pushing
    fi
}

automatic(){
    check_branch
    stages
    commit
    branch
    pushing
}

show_menu(){
    echo "========================"
    echo "== Git Project Helper =="
    echo "========================"
    check_branch
    echo
    echo "[!] Please select task!"
    echo
    echo "[1] Auto Push         [5] Branch    [9] Remote"
    echo "[2] Staged Files      [6] Merge     [10] Clear"
    echo "[3] Unstaged Files    [7] Pull      [11] Exit"
    echo "[4] Commit            [8] Push"
    read -p "[!] Your Choice: " SELECT
    case "$SELECT" in
        "1")
            automatic
            show_menu
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
            merge
            show_menu
            ;;
        "7")
            pulling
            show_menu
            ;;
        "8")
            pushing
            show_menu
            ;;
        "9")
            remote
            show_menu
            ;;
        "10")
            clear
            show_menu
            ;;
        "11")
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