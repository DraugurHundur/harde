# HARDE
Hardening RHEL 8.x. Using the guidelines from the [CIS RHEL 8 benchmark](https://www.cisecurity.org/benchmark/red_hat_linux/) and [ANSSI](https://www.ssi.gouv.fr/guide/recommandations-de-securite-relatives-a-un-systeme-gnulinux/). If you are looking for a more robust/complete solution, please consider [Lynis](https://github.com/CISOfy/Lynis)

Run `./harde.sh secure` to secure the system. Some questions are asked along the way when needed.

Run `./harde.sh audit` to audit the system.

## Basic principles
HARDE introduces the concept of a «maintenance» mode and a «normal» mode i.e. it is impossible to load a kernel module in «normal» mode and USB/ISO cannot be used. The /boot (and /boot/efi) partition is not mounted.

Run `/etc/maintenance_mode.sh` and reboot to load modules and/or update /boot(/efi)

sudo can only be run by a limited group of admins.

## Limitations
HARDE speaks French most of the time and often English. *You shouldn't use it if you don't speak both.*

HARDE disables IPv6 in all cases.

HARDE is not really documented (no documentation in English and minimal doc in French.)
## Known Issues
HARDE has only be tested on virtual machines right after the initial installation so far. *Use at your own risk*. You may lose data !

## Disk encryption
HARDE does not encrypt your disks and doesn't really care either. Use whatever suits you to encrypt your disks.
