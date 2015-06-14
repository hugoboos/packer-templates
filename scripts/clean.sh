#!/bin/bash

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

# Remove packages used for building the VirtualBox Guest Additions
yum remove -y kernel-headers kernel-devel gcc perl cloog-ppl cpp glibc-devel glibc-headers mpfr ppl

# Remove VirtualBox Guest Additions sources
rm -f /usr/src/vboxguest-${VBOX_VERSION}
rm -rf /opt/VBoxGuestAdditions-${VBOX_VERSION}/src

# Remove old kernels
rpm -qa kernel | grep -v -e "^kernel-$(uname -r)" | xargs yum remove -y

# Remove yum caches
yum clean all

# Remove DHCP leases
rm -f /var/lib/dhclient/*

# Temporary files
rm -rf /tmp/*

# Clear last logged-in users
rm -f /var/log/wtmp /var/log/btmp

# Clear logs
LOG_FILES=("cron" "dmesg" "dmesg.old" "dracut.log" "lastlog" "secure" "messages" "maillog")
for log_file in "${array[@]}"
do
  rm -f /var/log/${log_file}
done

# Remove network persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
sed -i "/^HWADDR/d" /etc/sysconfig/network-scripts/ifcfg-eth*
sed -i "/^UUID/d" /etc/sysconfig/network-scripts/ifcfg-eth*
sed -i "s/NM_CONTROLLED=yes)/NM_CONTROLLED=no/g" /etc/sysconfig/network-scripts/ifcfg-eth*

# Clear resolv.conf
> /etc/resolv.conf

# Clear auto-generated SSH keys
rm -f /etc/ssh/*key*

# Force re-creation of random-seed
rm -f /var/lib/random-seed

# Clear the history
history -c
> /root/.bash_history
