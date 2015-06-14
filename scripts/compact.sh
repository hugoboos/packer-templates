# Clear the swap memory
SWAP_UUID=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
SWAP_PARTITION=$(readlink -f /dev/disk/by-uuid/"${SWAP_UUID}")
MOUNTS=("/" "/boot" "/home" "/var" "/var/log" "/var/log/audit" "/tmp")

swapoff ${SWAP_PARTITION}
dd if=/dev/zero of=${SWAP_PARTITION} bs=1M
mkswap -U ${SWAP_UUID} ${SWAP_PARTITION}

# Zero out the drive for better compression
for MOUNT in ${MOUNTS[@]}; do
  dd if=/dev/zero of=${MOUNT}/EMPTY bs=1M
  rm -f ${MOUNT}/EMPTY
done

sync
