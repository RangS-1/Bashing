#!/bin/bash

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
        echo "[✓] PKGBUILD is not there!"
        start
    fi
}

create_pkgbuild(){
    read -rp "[!] maintainer     : " MAINTAINER
    read -rp "[!] pkgname        : " PKGNAME
    read -rp "[!] repository     : " REPOSITORY
    read -rp "[!] version(v1.0.0): " VERSION
    read -rp "[!] pkgrel(1)      : " PKGREL
    read -rp "[!] description    : " DESCRIPTION
    read -rp "[!] arch(any)      : " ARCH
    read -rp "[!] url            : " URL
    read -rp "[!] license(MIT)   : " LICENSE
    read -rp "[!] dependency     : " DEPENDENCY
    read -rp "[!] make dependency: " MAKEDEPENDS
    read -rp "[!] source         : " SOURCE
    read -rp "[!] sha256sum      : " SHA

    cat << EOF > PKGBUILDTEST
# Maintainer: $MAINTAINER
pkgname=$PKGNAME
_repo=$REPOSITORY
pkgver=$VERSION
pkgrel=$PKGREL
pkgdesc="$DESCRIPTION"
arch=('$ARCH')
url="$URL"
license=('$LICENSE')

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
    if [[ $VERSION = "" ]]; then
        sed -i "s/^pkgver=.*/pkgver=1.0.0/" PKGBUILD
    fi

    if [[ $PKGREL = "" ]]; then
        sed -i "s/^pkgrel=.*/pkgrel=1/" PKGBUILD
    fi

    if [[ $ARCH = "" ]]; then
        sed -i "s/^arch=.*/arch=('any')/" PKGBUILD
    fi

    if [[ $LICENSE = "" ]]; then
        sed -i "s/^license=.*/license=('MIT')/" PKGBUILD
    fi
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