#!/bin/bash

create_pkgbuild(){
    read -p "pkgname: " $PKGNAME
    cat << EOF > PKGBUILDTEST
# Maintainer: RangS-1 <rangga19sj@gmail.com>
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

create_pkgbuild