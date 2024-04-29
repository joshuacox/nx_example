#!/bin/sh
. ./.target
./arch-chroot-prep-host.sh
tar zcf - z.sh | ssh root@$TARGET 'tar zxvf -;sh z.sh'
./push.sh
tar zcf - install-cmd.sh | ssh admin@$TARGET 'tar zxvf -; echo bash -l install-cmd.sh '
