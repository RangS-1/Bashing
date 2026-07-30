#!/bin/bash

create_pkgbuild(){
    read -p "pkgname: " $PKGNAME
    cat << EOF > PKGBUILD
# Maintainer: 
pkgname=
_repo=
pkgver=1.0.0
pkgrel=1
pkgdesc="Nothing here"
arch=('any')
url=""
license=('')

depends=()

makedepends=()

source=(
    "$pkgname-$pkgver.tar.gz::https://github.com/RangS-1/${_repo}/archive/refs/tags/v$pkgver.tar.gz"
)

sha256sums=('')

build() {

}

package() {

}
EOF
}

run_namcap(){
    read -p "Would you like to use namcap(Y/n)? " RUNIT
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