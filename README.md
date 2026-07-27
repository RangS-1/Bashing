# Bashing

This repository contains several simple Bash scripts to help with everyday tasks, such as backing up folders, generating project templates, monitoring the system, and updating an Arch Linux system.

## Script List

- `backup.sh` — creates a backup of a folder in `.tar.gz` format
- `projectgenerator.sh` — creates web or Python project structures automatically
- `sysmon.sh` — displays system information in real time
- `updater.sh` — updates the Arch Linux system and AUR packages
- `maintenance.sh` — provides a simple maintenance menu for updates, cache cleanup, journal cleanup, and old downloads removal
- `githelper.sh` — provides an interactive Git helper for staging, committing, branching, merging, pushing, and remotes
- `laravelarch.sh` — installs and configures a Laravel development stack on Arch Linux

## Prerequisites

Make sure your system already has:

- `Bash`
- `git`
- `tar`
- `sudo`

For the monitoring, updater, and Laravel setup scripts, the following commands are also required:

- `free`, `df`, `uptime`, `ip`, `nmcli` for `sysmon.sh`
- `pacman`, `yay`, `paccache` for `updater.sh`
- `journalctl` for `maintenance.sh`
- `composer`, `php`, `php-fpm`, `mariadb`, `nginx` for `laravelarch.sh`

## Installation with Git

If you want to download this repository from Git, run:

```bash
git clone <repository-url>
cd Bashing
chmod +x backup.sh projectgenerator.sh sysmon.sh updater.sh maintenance.sh githelper.sh laravelarch.sh
```

If you are already inside the local repository folder, you can simply run:

```bash
cd /path/to/Bashing
chmod +x backup.sh projectgenerator.sh sysmon.sh updater.sh maintenance.sh githelper.sh laravelarch.sh
```

## How to Use

### 1. Backup a Folder

This script creates a backup of the folder you choose into the `$HOME/backup` directory.

```bash
./backup.sh
```

Then enter the folder path you want to back up when prompted.

### 2. Create Projects Automatically

This script can create web or Python project templates.

#### Web Template

```bash
./projectgenerator.sh web project-name
```

#### Python Template

```bash
./projectgenerator.sh python project-name
```

### 3. System Monitor

This script displays RAM, disk, battery, network, IP, and uptime information periodically.

```bash
./sysmon.sh
```

This script will keep running and refresh the display every 2 seconds. Press `Ctrl+C` to stop it.

### 4. Update an Arch Linux System

This script will:

1. Check internet connectivity
2. Run `pacman -Syu`
3. Run AUR updates with `yay`
4. Ask whether to clear the cache

```bash
./updater.sh
```

> This script is suitable for Arch Linux systems where `yay` is already installed.

### 5. Maintenance Menu

This script provides a simple interactive menu for common maintenance tasks.

```bash
./maintenance.sh
```

You can choose options to:

- run a full maintenance routine
- update system or AUR packages
- clean package cache
- clear old journal logs
- remove old files from Downloads
- check disk usage

### 6. Git Helper

This script provides an interactive menu for common Git tasks such as staging, unstaging, committing, branching, merging, setting remotes, and pushing.

```bash
./githelper.sh
```

### 7. Laravel Arch Setup

This script installs and configures a Laravel application stack on Arch Linux, including `nginx`, `php`, `php-fpm`, `mariadb`, and `composer`.

```bash
sudo ./laravelarch.sh
```

## Folder Structure

```text
Bashing/
├── docs/
├── backup.sh
├── githelper.sh
├── laravelarch.sh
├── maintenance.sh
├── projectgenerator.sh
├── sysmon.sh
└── updater.sh
```

## Tips

- Run the scripts from this repository folder, or use the full path if you want to run them from another location.
- If you encounter execution permission errors, run `chmod +x` as shown above.
- For safety, make sure you understand the contents of a script before running it.

## Contribution

If you want to develop this repository further, please fork the repository, create a new branch, and submit a pull request.
