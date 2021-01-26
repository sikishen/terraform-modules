#!/bin/bash
sudo -i
DEVICE=/dev/nvme1n1 
echo -e "n\np\n1\n\n\nt\n83\nw\n" | fdisk ${DEVICE}
DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then
mkfs.ext4 ${DEVICE}p1
fi
mkdir -p /mnt
echo "${DEVICE}p1 /mnt ext4 defaults 0 0" >> /etc/fstab
mount /mnt