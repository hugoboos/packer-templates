#!/bin/bash

VERSION=$(cat /home/vagrant/.vbox_version)
ISO_PATH="/home/vagrant/VBoxGuestAdditions_${VERSION}.iso"
MOUNT_PATH="/mnt"

mount -o loop ${ISO_PATH} ${MOUNT_PATH}
sh ${MOUNT_PATH}/VBoxLinuxAdditions.run

umount ${MOUNT_PATH}
rm -f ${ISO_PATH}
