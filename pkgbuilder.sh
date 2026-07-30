#!/bin/env bash

check_pkgbuild(){
    if [ -f "PKGBUILD" ]; then
    	echo "[!] PKGBUILD was found!"
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
        printf "[✓] PKGBUILD is not there!\n"
        create_pkgbuild
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

    echo "[!] Make PKGBUILD..."
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
    read -p "[!] Would you like to use namcap(Y/n)? " RUNIT
    if [[ "$RUNIT" == "Y" || "$RUNIT" == "y" ]]; then
        namcap PKGBUILD
    elif [[ "$RUNIT" == "N" || "$RUNIT" == "n" ]]; then
        echo "[X] Skip."
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
    echo "[✓] Create PKGBBUILD with Python Build"
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
    echo "[✓] Create PKGBBUILD with Rust Build"
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
    echo "[✓] Create PKGBBUILD with Go Build"
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
    echo "[✓] Create PKGBBUILD with Cmake Build"
}

choose_build(){
    printf "[1] Python    [3] Go\n"
    printf "[2] Rust      [4] Cmake (C/C++)\n"
    read -rp "[!] Choose Build: " BUILD

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