#!/bin/sh
. ./.target
ssh-keygen -R $TARGET 
ssh-keyscan -H $TARGET >> ~/.ssh/known_hosts
ssh-copy-id root@$TARGET 
ssh root@$TARGET 'pacman -Sy'
ssh root@$TARGET 'curl -s https://raw.githubusercontent.com/eoli3n/archiso-zfs/master/init | bash'
ssh root@$TARGET 'sudo groupadd -g 30000 nixbld && sudo useradd -u 30000 -g nixbld -G nixbld nixbld && mkdir -p /home/nixbld && cp -a /root/.ssh /home/nixbld && chown -R nixbld: /home/nixbld'
ssh root@$TARGET 'sudo groupadd -g 30001 admin && sudo useradd -u 30001 -g admin -G admin admin && mkdir -p /home/admin && cp -a /root/.ssh /home/admin && chown -R admin: /home/admin'
ssh root@$TARGET "echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers.d/wheel && gpasswd -a nixbld wheel && gpasswd -a admin wheel"
ssh root@$TARGET "mkdir /nix; mount -t tmpfs none /nix"
ssh admin@$TARGET "curl -L https://nixos.org/nix/install | sh"
ssh admin@$TARGET "echo '. /home/admin/.nix-profile/etc/profile.d/nix.sh' >> /home/admin/.profile"
tar zcf - tools.sh | ssh admin@$TARGET 'tar zxvf -; bash -l tools.sh; rm tools.sh'
