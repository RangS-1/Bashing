#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Error: Sudo is needed!"
    exit 1
fi

PACKAGE=("nginx" "php" "php-fpm" "composer" "mariadb" "nodejs" "npm")
install_packages(){
    pacman -S --needed "${PACKAGE[@]}"
}

configure_mariadb(){
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    systemctl enable --now mariadb
    printf "\n\nY\nN\nY\nY\nY" | mariadb-secure-installation
    echo "[✓] Mariadb: $(systemctl is-active mariadb)"
}

configure_phpfpm(){
    systemctl enable --now php-fpm
    echo "[✓] php-fpm: $(systemctl is-active php-fpm)"
}

start_nginx(){
    systemctl enable --now nginx
    echo "[✓] nginx: $(systemctl is-active nginx)"
}

makelaravel(){
    read -p "[!] Your laravel Project: " LARAVEL
    if [[ "$LARAVEL" == "" ]]; then
        echo "[X] Project name cannot Empty!"
        makelaravel
    else
        sudo -u $SUDO_USER composer create-project laravel/laravel "$LARAVEL"
    fi
}

configure_database(){
    cd "$LARAVEL"
    sed -i 's/^DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
    sed -i 's/^# DB_HOST=.*/DB_HOST=127.0.0.1/' .env
    sed -i 's/^# DB_PORT=.*/DB_PORT=3306/' .env
    sed -i 's/^# DB_DATABASE=.*/DB_DATABASE=laravel/' .env
    sed -i 's/^# DB_USERNAME=.*/DB_USERNAME=rangs/' .env
    sed -i 's/^# DB_PASSWORD=.*/DB_PASSWORD=1346/' .env
    php artisan key:generate
    php artisan migrate
}

start(){
    for pkg in "${PACKAGE[@]}"; do
        if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
            pacman -S --needed "$pkg"
        fi
    done
    configure_mariadb
    configure_phpfpm
    start_nginx
    makelaravel
    configure_database
}

start