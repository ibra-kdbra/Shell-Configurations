# Shell Configurations Repository

Welcome to the Shell Configurations repository, a curated collection of scripts and configuration files designed for Linux administrators and power users. This repository serves as a comprehensive resource for automating tasks, managing systems, and enhancing shell environments.

![Linux](https://img.shields.io/badge/OS-Linux-blue?style=for-the-badge&logo=linux)
![Shell Script](https://img.shields.io/badge/Language-Shell%20Script-green?style=for-the-badge&logo=gnu-bash)
![PowerShell](https://img.shields.io/badge/Language-PowerShell-blueviolet?style=for-the-badge&logo=powershell)

---

## Table of Contents

- [Shell Configurations Repository](#shell-configurations-repository)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Repository Structure](#repository-structure)
  - [Getting Started](#getting-started)
  - [Contributing](#contributing)
  - [License](#license)

---

## Introduction

This repository is a collection of shell scripts and configuration files that I have created or modified over the years. It is intended to be a living project, and I will be adding new scripts and configurations as I develop them. The scripts are written to be as POSIX-compliant as possible, but some may require Bash or other modern shells.

---

## Repository Structure

The repository is organized into the following directories:

| Directory | Description |
|---|---|
| [**`bash-script-examples/`**](./bash-script-examples/) | A collection of Bash script examples for learning and reference, categorized by functionality. |
| [**`dash-static/`**](./dash-static/) | Scripts for building a static linked Debian Almquist shell (dash) with `musl`. |
| [**`Debian_System/`**](./Debian_System/) | Configuration files and scripts for setting up a Debian-based system, including `dmenu`, `dwm`, and `sxhkd`. |
| [**`game-converter/`**](./game-converter/) | A GUI-based shell script for converting game formats using `chdman` and `ciso`. |
| [**`Intune_Patch_Compliance/`**](./Intune_Patch_Compliance/) | A PowerShell script to generate Intune patch compliance reports. |
| [**`LinuxAudit/`**](./LinuxAudit/) | A security audit script to gather information about a Linux system for hardening purposes. |
| [**`Mint-Cinnamon-21.2/`**](./Mint-Cinnamon-21.2/) | Scripts for configuring and customizing Linux Mint Cinnamon 21.2. |
| [**`Miscreated_Docker/`**](./Miscreated_Docker/) | Docker scripts for creating and managing a Miscreated game server. |
| [**`PowerShell_ArgumentCompleters/`**](./PowerShell_ArgumentCompleters/) | PowerShell argument completers from `TabExpansionPlusPlus`, updated for modern PowerShell. |
| [**`Self_assigned_ssl/`**](./Self_assigned_ssl/) | Scripts for generating self-signed SSL/TLS certificates. |
| [**`setDualNet/`**](./setDualNet/) | A script to automatically configure static IPs for dual-network setups (WLAN/Ethernet). |
| [**`SSH_L3_Tunnels/`**](./SSH_L3_Tunnels/) | A robust tool for managing Layer 3 SSH tunnels with dynamic IP addressing and network namespace isolation. |
| [**`Swtich_QT_Versions/`**](./Swtich_QT_Versions/) | A script to dynamically switch between Qt versions on Arch Linux. |
| [**`Sysupgrade-debian/`**](./Sysupgrade-debian/) | A simple script to update and upgrade Debian-based systems. |
| [**`Useful_Snippets/`**](./Useful_Snippets/) | A collection of useful, POSIX-compliant shell snippets for daily use. |
| [**`vfplot-examples/`**](./vfplot-examples/) | Example plots for the `vfplot` homepage, requiring GMT and POV-Ray. |

---

## Getting Started

To get started with the scripts in this repository, you will need a Linux-based operating system and a working knowledge of the shell. Most scripts are written in Bash, but some may have other dependencies, which will be listed in their respective `README.md` files.

To use a script, clone the repository and navigate to the desired directory:

```bash
git clone https://github.com/ibra-kdbra/Shell-Configurations.git
cd Shell-Configurations
```

Each directory contains a `README.md` file with more detailed instructions on how to use the scripts within it.

---

## Contributing

Contributions are welcome! If you have a script or configuration that you would like to add, please fork the repository and submit a pull request. Please ensure that your contributions are well-documented and follow the existing coding style.

---

## License

This repository is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.
