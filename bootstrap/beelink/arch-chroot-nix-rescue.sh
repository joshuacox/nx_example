#!/bin/sh
. ./.target
./arch-chroot-prep-host.sh
tar zcf - zr.sh | ssh root@$TARGET 'tar zxvf -;sh zr.sh'
./push.sh
tar zcf - install-cmd.sh | ssh admin@$TARGET 'tar zxvf -; bash -l install-cmd.sh '
