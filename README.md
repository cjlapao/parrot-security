# Parrot Security Helpers and Utilities

## How to use

### Parrot Security Linux Installer/NetInstaller ISO

1. Download Parrot Security Architect ISO from [https://www.parrotsec.org/download/](https://www.parrotsec.org/download/)
2. Create a new VM that boots from the Parrot Security ISO
3. At the Parrot Security boot menu, press `<tab>`.
4. Edit the command line and replace the below

        preseed/url=/cdrom/simple-cdd/default.preseed simple-cdd/profiles=kali,offline desktop=xfce

    with

        auto=true url=https://raw.githubusercontent.com/cjlapao/parrot-/main/preseed/{preseed_file} priority=critical