# Clear the swap memory
SWAP_UUID=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
SWAP_PARTITION=$(readlink -f /dev/disk/by-uuid/"${SWAP_UUID}")

swapoff ${SWAP_PARTITION}
dd if=/dev/zero of=${SWAP_PARTITION} bs=1M
mkswap -U ${SWAP_UUID} ${SWAP_PARTITION}

# Zero out the drive for better compression
dd if=/dev/zero of=/boot/EMPTY bs=1M
rm -f /boot/EMPTY

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

sync
