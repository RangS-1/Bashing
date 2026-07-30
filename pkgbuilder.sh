#!/bin/env bash

check_pkgbuild(){
    if [ -f "PKGBUILD" ]; then
    	echo -e "\e[35m[!]\e[0m PKGBUILD was found!"
    	read -p "Would you like to overwrite PKGBUILD? " CHECK
        if [[ "$CHECK" == "Y" || "$CHECK" == "y" ]]; then
            create_pkgbuild
        elif [[ "$CHECK" == "N" || "$CHECK" == "n" ]]; then
            echo "[X] Cancelling..."
            exit 1
        else
            check_pkgbuild
        fi
    else
        printf "\e[32m[✓]\e[0m PKGBUILD is not there!\n"
        create_pkgbuild
    fi
}

create_pkgbuild(){
    read -rp "$(echo -e "\e[35m[!]\e[0m") maintainer     : " MAINTAINER
    read -rp "$(echo -e "\e[35m[!]\e[0m") pkgname        : " PKGNAME
    read -rp "$(echo -e "\e[35m[!]\e[0m") repository     : " REPOSITORY
    read -rp "$(echo -e "\e[35m[!]\e[0m") version[v1.0.0]: " VERSION
    read -rp "$(echo -e "\e[35m[!]\e[0m") pkgrel      [1]: " PKGREL
    read -rp "$(echo -e "\e[35m[!]\e[0m") description    : " DESCRIPTION
    read -rp "$(echo -e "\e[35m[!]\e[0m") arch(any)      : " ARCH
    read -rp "$(echo -e "\e[35m[!]\e[0m") url            : " URL
    read -rp "$(echo -e "\e[35m[!]\e[0m") license   [MIT]: " LICENSE
    read -rp "$(echo -e "\e[35m[!]\e[0m") dependency     : " DEPENDENCY
    read -rp "$(echo -e "\e[35m[!]\e[0m") make dependency: " MAKEDEPENDS
    read -rp "$(echo -e "\e[35m[!]\e[0m") source         : " SOURCE
    read -rp "$(echo -e "\e[35m[!]\e[0m") sha256sum      : " SHA

    echo -e "\e[35m[!]\e[0m Make PKGBUILD..."
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
    "$PKGNAME-$PKGVER.tar.gz::$URL"
)

sha256sums=('$SHA')
EOF
}

run_namcap(){
    echo -e -n "\e[35m[!]\e[0m Would you like to use namcap(Y/n)? "
    read RUNIT
    if [[ "$RUNIT" == "Y" || "$RUNIT" == "y" ]]; then
        namcap PKGBUILD
    elif [[ "$RUNIT" == "N" || "$RUNIT" == "n" ]]; then
        echo -e "\e[31m[X]\e[0m Skip namcap check..."
    else
        run_namcap
    fi
}

python_build(){
    cat << EOF >> PKGBUILD
build() {
    cd "$_repo"

    python -m build --wheel --no-isolation
}

package() {
    cd "$_repo"

    python -m installer \
        --destdir="$pkgdir" \
        dist/*.whl
}
EOF
    echo -e "\e[32m[✓]\e[0m Create PKGBBUILD with Python Build"
}

rust_build(){
    cat << EOF >> PKGBUILD
build() {
    cd "$_repo"

    cargo build --release --locked
}

package() {
    install -Dm755 \
        "$_repo/target/release/$pkgname" \
        "$pkgdir/usr/bin/$pkgname"
}
EOF
    echo -e "\e[32m[✓]\e[0m Create PKGBBUILD with Rust Build"
}

go_build(){
    cat << EOF >> PKGBUILD
build() {
    cd "$_repo"

    go build \
        -trimpath \
        -buildmode=pie \
        -mod=readonly \
        -modcacherw \
        -o "$pkgname"
}

package() {
    install -Dm755 \
        "$_repo/$pkgname" \
        "$pkgdir/usr/bin/$pkgname"
}
EOF
    echo -e "\e[32m[✓]\e[0m Create PKGBBUILD with Go Build"
}

cmake_build(){
    cat << EOF >> PKGBUILD
build() {
    cmake \
        -B build \
        -S "$_repo" \
        -DCMAKE_BUILD_TYPE=None \
        -DCMAKE_INSTALL_PREFIX=/usr

    cmake --build build
}

package() {
    DESTDIR="$pkgdir" \
        cmake --install build
}
EOF
    echo -e "\e[32m[✓]\e[0m Create PKGBBUILD with Cmake Build"
}

choose_build(){
    echo
    printf "[1] Python    [3] Go\n"
    printf "[2] Rust      [4] Cmake (C/C++)\n"
    read -rp "$(echo -e "\e[35m[!]\e[0m") Choose Build: " BUILD

    case "$BUILD" in
        "1")
            python_build    
            ;;
        "2")
            rust_build
            ;;
        "3")
            go_build
            ;;
        "4")
            cmake_build
            ;;
        *)
            choose_build
            ;;
    esac
}

start(){
    choose_build
    run_namcap
}

check_pkgbuild
start