BOOT_DISK=/dev/disk/by-partuuid/deadbeed01
ROOT_DISK=/dev/disk/by-partuuid/deadbeed02
ZFS_DISK=/dev/disk/by-partuuid/deadbeef03
RANCHER_DISK=/dev/disk/by-partuuid/deadbeef04


mkfs.fat -F 32 -n NIXBOOT $BOOT_DISK
mkfs.ext4 -L rancher $RANCHER_DISK
zpool create \
-O compression=zstd \
-O mountpoint=none \
-O xattr=sa \
-O acltype=posixacl \
-o ashift=13 \
-O recordsize=64k \
-O atime=off \
nixroot $ROOT_DISK
zpool create \
-O compression=zstd \
-O mountpoint=none \
-O xattr=sa \
-O acltype=posixacl \
-o ashift=13 \
-O recordsize=1M \
-O atime=off \
nixpool $ZFS_DISK

zfs create -o mountpoint=legacy nixroot/root
zfs create -o mountpoint=legacy nixroot/nix
zfs create -o mountpoint=legacy nixroot/var
zfs create -o mountpoint=legacy nixroot/home
zfs create -o mountpoint=legacy nixpool/opt
zfs create -o mountpoint=legacy nixpool/unreal

mount -t zfs nixroot/root /mnt
mkdir -p /mnt/nix /mnt/var /mnt/home /mnt/boot /mnt/opt /mnt/unreal /mnt/var/lib/rancher
mount -t zfs nixroot/var /mnt/var
mkdir -p /mnt/var/lib/rancher

mount /dev/disk/by-label/NIXBOOT /mnt/boot
mount -t zfs nixroot/nix /mnt/nix
mount -t zfs nixroot/home /mnt/home
mount -t zfs nixpool/unreal /mnt/unreal
mount -t zfs nixpool/opt /mnt/opt

mount /dev/disk/by-label/rancher /mnt/var/lib/rancher
