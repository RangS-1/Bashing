#!/bin/env bash

check_pkgbuild(){
    if [ -f "PKGBUILD" ]; then
    	echo "[!] PKGBUILD was found!"
    	read -p "Would you like to overwrite PKGBUILD? " CHECK
        if [[ "$CHECK" == "Y" || "$CHECK" == "y" ]]; then
            start
        elif [[ "$CHECK" == "N" || "$CHECK" == "n" ]]; then
            echo "[X] Cancelling..."
            exit 1
        else
            check_pkgbuild
        fi
    else
        printf "[✓] PKGBUILD is not there!\n"
        start
    fi
}

create_pkgbuild(){
    read -rp "[!] maintainer     : " MAINTAINER
    read -rp "[!] pkgname        : " PKGNAME
    read -rp "[!] repository     : " REPOSITORY
    read -rp "[!] version[v1.0.0]: " VERSION
    read -rp "[!] pkgrel      [1]: " PKGREL
    read -rp "[!] description    : " DESCRIPTION
    read -rp "[!] arch(any)      : " ARCH
    read -rp "[!] url            : " URL
    read -rp "[!] license   [MIT]: " LICENSE
    read -rp "[!] dependency     : " DEPENDENCY
    read -rp "[!] make dependency: " MAKEDEPENDS
    read -rp "[!] source         : " SOURCE
    read -rp "[!] sha256sum      : " SHA

    cat << EOF > PKGBUILD
# Maintainer: $MAINTAINER
pkgname=$PKGNAME
_repo=$REPOSITORY
pkgver=${VERSION:-1.0.0}
pkgrel=${PKGREL:-1}
pkgdesc="$DESCRIPTION"
arch=${ARCH:-('any')}
url="$URL"
license=${LICENSE:-('MIT')}

depends=($DEPENDENCY)

makedepends=($MAKEDEPENDS)

source=(
    "$SOURCE"
)

sha256sums=('$SHA')

build() {

}

package() {

}
EOF
}

run_namcap(){
    read -p "[!] Would you like to use namcap(Y/n)? " RUNIT
    if [[ "$RUNIT" == "Y" || "$RUNIT" == "y" ]]; then
        namcap PKGBUILD
    elif [[ "$RUNIT" == "N" || "$RUNIT" == "n" ]]; then
        echo "[X] Skip."
    else
        run_namcap
    fi
}

start(){
    create_pkgbuild
    run_namcap
}

start