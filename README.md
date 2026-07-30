# Bashing

This repository contains a collection of Bash scripts for everyday system administration and development tasks on Linux, especially for Arch-based systems.

## Scripts Included

- `backup.sh` — creates a backup of a chosen folder into the home backup directory as a `.tar.gz` archive.
- `updater.sh` — checks connectivity and runs system updates, AUR updates, and optional cache cleanup.
- `sysmon.sh` — displays system status such as RAM usage, disk usage, battery, network, IP, and uptime.
- `projectgenerator.sh` — creates starter project templates for web or Python projects.
- `maintenance.sh` — interactive maintenance menu for update checks, cache cleanup, journal cleanup, removing old downloads, and disk usage checks.
- `githelper.sh` — interactive helper for common Git operations such as staging, unstaging, committing, branching, merging, pushing, and managing remotes.
- `laravelarch.sh` — installs and configures a Laravel development stack using `nginx`, `php`, `php-fpm`, `mariadb`, `composer`, and related services.
- `nuser.sh` — creates a new system user with sudo access and a Bash shell.
- `pkgbuilder.sh` — interactive helper to create or update a `PKGBUILD` file.

## Prerequisites

Most scripts require Bash and basic core utilities. Depending on the script, you may also need:

- `git` for `githelper.sh`
- `pacman`, `paccache`, `yay`, `sudo` for `updater.sh` and `maintenance.sh`
- `nmcli`, `df`, `free`, `ip`, `uptime` for `sysmon.sh`
- `composer`, `php`, `php-fpm`, `mariadb`, `nginx` for `laravelarch.sh`
- `useradd`, `passwd` for `nuser.sh`

## Installation

### From Git

Clone the repository and make the scripts executable:

```bash
git clone <repository-url>
cd Bashing
chmod +x *.sh
```

If you are already inside the repository folder, you can run:

```bash
chmod +x *.sh
```

### From AUR (yay)

```bash
yay -S bashing
```

### From AUR (paru)

```bash
paru -S bashing
```

## Usage

### 1. Backup a folder

```bash
./backup.sh
```

Enter the folder path when prompted.

### 2. Git helper

```bash
./githelper.sh
```

Use the menu to manage Git actions interactively.

### 3. Laravel setup on Arch Linux

```bash
sudo ./laravelarch.sh
```

This script installs and configures the required services and then helps create a Laravel project.

### 4. Maintenance menu

```bash
./maintenance.sh
```

Choose from update, cleanup, journal, and download management tasks.

### 5. Create a new user

```bash
sudo ./nuser.sh
```

The script will ask for a username and create the account.

### 6. Create a PKGBUILD

```bash
./pkgbuilder.sh
```

This interactive script helps generate a `PKGBUILD` file for packaging.

### 7. Generate project templates

```bash
./projectgenerator.sh web project-name
./projectgenerator.sh python project-name
```

### 8. Monitor system status

```bash
./sysmon.sh
```

The script refreshes every 2 seconds until you stop it with `Ctrl+C`.

### 9. Update the system

```bash
./updater.sh
```

This script checks internet connectivity, updates system packages, optionally updates AUR packages, and can clean the package cache.

## Repository Structure

```text
Bashing/
├── docs/
├── backup.sh
├── githelper.sh
├── laravelarch.sh
├── maintenance.sh
├── nuser.sh
├── pkgbuilder.sh
├── projectgenerator.sh
├── sysmon.sh
├── updater.sh
├── PKGBUILD
└── README.md
```

## Notes

- Run scripts from the repository folder or use their full path.
- If you get permission errors, run `chmod +x` again.
- Some scripts are intended for Arch Linux or require root privileges. Review them before running them on your system.

## Contribution

Feel free to improve the scripts or add new helpers. Fork the repository, create a branch, and submit a pull request if you want to contribute.
