# harde
Hardening RHEL 8.x

## Basic principles
harde introduces the concept of a «maintenance» mode and a «normal» mode i.e. it is impossible to load a kernel module in «normal» mode and USB/ISO cannot be used.

sudo can only be run by a limited group of admins.

## Limitations
HARDE speaks French most of the time and often English. *You shouldn't use it if you don't speak both.*

HARDE disables IPv6 in all cases.

HARDE is not really documented (no documentation in English and minimal doc in French.)
## Known Issues
harde has only be tested on virtual machines right after the initial installation. *Use at your own risk*. You may lose data !

## Disk encryption
harde does not encrypt your disks and doesn't really care either. Use whatever suits you to encrypt your disks.
