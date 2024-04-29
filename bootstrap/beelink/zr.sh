zpool import -f nixroot
zpool import -f nixpool
mount -t zfs nixroot/root /mnt
#mount /dev/disk/by-label/nixroot /mnt
mkdir -p /mnt/nix /mnt/var /mnt/home /mnt/boot /mnt/opt /mnt/unreal /mnt/var/lib/rancher
mount -t zfs nixroot/var /mnt/var
mkdir -p /mnt/var/lib/rancher

mount /dev/disk/by-label/NIXBOOT /mnt/boot
mount -t zfs nixroot/nix /mnt/nix
mount -t zfs nixroot/home /mnt/home
mount -t zfs nixpool/unreal /mnt/unreal
mount -t zfs nixpool/opt /mnt/opt

mount /dev/disk/by-label/rancher /mnt/var/lib/rancher

