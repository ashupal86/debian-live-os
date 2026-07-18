# Build Your Own Custom Debian Live Distribution

Create a fully customized Debian Live ISO using **live-build**. This project provides a ready-to-use configuration that lets you build a minimal or feature-rich Debian-based operating system with complete control over the filesystem, packages, and build process.

---

# Prerequisites

* A Debian or Debian-based Linux distribution
* `git`
* `sudo` privileges
* Internet connection

---

# Getting Started

## 1. Clone the Repository

```bash
git clone --depth 1 https://github.com/ashupal86/debian-live-os
cd debian-live-os
```

---

## 2. Install the Latest `live-build`

Make the installation script executable and run it.

```bash
sudo chmod +x install-live-build.sh
./install-live-build.sh
```

The script installs the latest version of **live-build**, which is the official Debian tool used to generate Live ISO images.

---

## 3. Enter the Build Directory

```bash
cd os
```

This directory contains the entire Live Build configuration used to generate the custom operating system.

---

## 4. Generate the Build Structure

Run:

```bash
lb config
```

This command reads the configuration and creates the required build structure.

It prepares the directories and metadata required for the Debian Live build process.

---

## 5. Customize Your Distribution

After running `lb config`, customize your operating system as needed.

Common customizations include:

* Adding or removing packages
* Creating custom users
* Adding wallpapers and themes
* Including scripts
* Modifying system configuration
* Adding custom services
* Installing firmware and drivers
* Creating custom boot menus

The `config/` directory contains all the files used to generate the final filesystem.

---
## 5.1 Add dependency or packages(Optional)

it will copy a package list into the iso for basic testing
`cp ~/Desktop/debian-live-os/package.list.chroot config/package-lists/my-package.list.chroot`

## 6. Build the ISO

Once customization is complete, build the ISO:

```bash
sudo lb build
```

Depending on your hardware and selected packages, this may take several minutes.

When the build completes successfully, the generated ISO will be available in the project directory.

---

# Understanding the Configuration

The build configuration is created using the following command:

```sh
#!/bin/sh

lb config \
    --distribution bookworm \
    --debian-installer none \
    --archive-areas "main contrib non-free non-free-firmware" \
    --binary-images iso-hybrid \
    --debootstrap-options "--variant=minbase" \
    --apt apt
```

Below is an explanation of each option.

---

## `--distribution bookworm`

Specifies the Debian release to build.

Examples:

* `bookworm`
* `trixie`
* `sid`

Changing this option changes the Debian version used as the base system.

---

## `--debian-installer`

Controls whether the Debian installer is included.

Possible values:

| Value    | Description                                                         |
| -------- | ------------------------------------------------------------------- |
| `none`   | No installer is included. Boots directly into the live environment. |
| `live`   | Includes the Debian Live Installer.                                 |
| `normal` | Includes the standard Debian Installer.                             |

If you only need a portable Live OS, `none` is usually the best choice.

---

## `--archive-areas`

Defines which Debian repository sections are available during the build.

```text
main
contrib
non-free
non-free-firmware
```

### Repository Sections

**main**

* Official free software maintained by Debian.

**contrib**

* Free software that depends on non-free components.

**non-free**

* Proprietary packages and drivers.

**non-free-firmware**

* Firmware required for modern Wi-Fi adapters, GPUs, Bluetooth devices, and other hardware.

For maximum hardware compatibility, enabling all four sections is recommended.

---

## `--binary-images iso-hybrid`

Specifies the output image format.

`iso-hybrid` creates a hybrid ISO that can boot from:

* USB drives
* DVDs
* CDs
* Virtual machines
* Most modern BIOS and UEFI systems

This is the recommended format for most users.

---

## `--debootstrap-options "--variant=minbase"`

Controls how the base Debian system is installed.

Available variants include:

| Variant    | Description                                               |
| ---------- | --------------------------------------------------------- |
| `required` | Standard minimal Debian installation.                     |
| `minbase`  | Smaller installation containing only essential packages.  |
| `buildd`   | Includes packages commonly required for package building. |

`minbase` is recommended when creating lightweight distributions.

---

## `--apt apt`

Specifies the package manager used during the build.

Normally this should remain:

```sh
--apt apt
```

---

# Useful `live-build` Commands

## Clean Previous Builds

Remove generated files while keeping your configuration.

```bash
sudo lb clean
```

To remove all generated files, caches, and temporary data:

```bash
sudo lb clean --purge
```

This is recommended before rebuilding after major configuration changes.

---

## Regenerate the Build Configuration

If you modify the configuration script or change build options:

```bash
lb config
```

Run this again before building.

---

## Build the ISO

```bash
sudo lb build
```

Generates the complete Debian Live ISO.

---

## Rebuild from Scratch

A typical rebuild workflow looks like:

```bash
sudo lb clean --purge
lb config
sudo lb build
```

---

# Project Structure

```text
os/
├── auto/
├── config/
├── hooks/
├── includes/
├── package-lists/
├── preseed/
└── ...
```

### Important Directories

| Directory        | Purpose                                               |
| ---------------- | ----------------------------------------------------- |
| `config/`        | Main live-build configuration files                   |
| `package-lists/` | Packages to install in the live system                |
| `includes/`      | Files copied directly into the final filesystem       |
| `hooks/`         | Scripts executed during the build process             |
| `preseed/`       | Automated Debian Installer configuration (if enabled) |

---

# Customization Ideas

You can customize nearly every aspect of the operating system, including:

* Desktop environment
* Window manager
* Themes and icons
* Wallpapers
* Boot splash
* Installed applications
* System services
* Kernel packages
* Firmware
* User accounts
* Shell configuration
* Fonts
* Drivers
* Custom scripts
* Branding and logos

---

# Troubleshooting

### Build fails after modifying configuration

Clean the build directory and regenerate the configuration:

```bash
sudo lb clean --purge
lb config
sudo lb build
```

---

### Package not found

Verify that the appropriate repository section is enabled in:

```sh
--archive-areas "main contrib non-free non-free-firmware"
```

---

### Changes are not reflected

Old build artifacts may still be cached.

Run:

```bash
sudo lb clean --purge
lb config
sudo lb build
```

---

# References

* Debian Live Build Documentation: https://live-team.pages.debian.net/live-manual/
* Debian Project: https://www.debian.org/
