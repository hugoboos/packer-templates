# == Class: cis::ch_1_install_updates_patches_and_additional_security_software
#
class cis::ch_1_install_updates_patches_and_additional_security_software {

  # 1.1.1 Create Separate Partition for /tmp (Scored)
  # 1.1.2 Set nodev option for /tmp Partition (Scored)
  # 1.1.3 Set nosuid option for /tmp Partition (Scored)
  # 1.1.4 Set noexec option for /tmp Partition (Scored)
  mount { '/tmp':
    ensure  => mounted,
    options => 'nodev,nosuid,noexec',
    pass    => 2,
  }

  # 1.1.5 Create Separate Partition for /var (Scored)
  mount { '/var':
    ensure => mounted,
    pass   => 1,
  }

  # 1.1.6 Bind Mount the /var/tmp directory to /tmp (Scored)
  mount { '/var/tmp':
    ensure  => mounted,
    device  => '/tmp',
    fstype  => 'none',
    options => 'bind',
  }

  # 1.1.7 Create Separate Partition for /var/log (Scored)
  mount { '/var/log':
    ensure => mounted,
    pass   => 2,
  }

  # 1.1.8 Create Separate Partition for /var/log/audit (Scored)
  mount { '/var/log/audit':
    ensure => mounted,
    pass   => 2,
  }

  # 1.1.9 Create Separate Partition for /home (Scored)
  # 1.1.10 Add nodev Option to /home (Scored)
  mount { '/home':
    ensure  => mounted,
    options => 'nodev',
    pass    => 1,
  }

  # 1.1.11 Add nodev Option to Removable Media Partitions (Not Scored)
  # 1.1.12 Add noexec Option to Removable Media Partitions (Not Scored)
  # 1.1.13 Add nosuid Option to Removable Media Partitions (Not Scored)
  # [No removable media is installed]

  # 1.1.14 Add nodev Option to /dev/shm Partition (Scored)
  # 1.1.15 Add nosuid Option to /dev/shm Partition (Scored)
  # 1.1.16 Add noexec Option to /dev/shm Partition (Scored)
  mount { '/dev/shm':
    options => 'nodev,nosuid,noexec',
  }

  # 1.1.17 Set Sticky Bit on All World-Writable Directories (Scored)
  file { '/tmp':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '1777',
  }

  # 1.1.18 Disable Mounting of cramfs Filesystems (Not Scored)
  # 1.1.19 Disable Mounting of freevxfs Filesystems (Not Scored)
  # 1.1.20 Disable Mounting of jffs2 Filesystems (Not Scored)
  # 1.1.21 Disable Mounting of hfs Filesystems (Not Scored)
  # 1.1.22 Disable Mounting of hfsplus Filesystems (Not Scored)
  # 1.1.23 Disable Mounting of squashfs Filesystems (Not Scored)
  # 1.1.24 Disable Mounting of udf Filesystems (Not Scored)
  # 4.6.1 Disable DCCP (Not Scored)
  # 4.6.2 Disable SCTP (Not Scored)
  # 4.6.3 Disable RDS (Not Scored)
  # 4.6.4 Disable TIPC (Not Scored)
  file { '/etc/modprobe.d/cis.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => 'puppet:///modules/cis/etc/modprobe.d/cis.conf',
  }

  # 1.2.1 Verify CentOS GPG Key is Installed (Scored)
  package { 'gpg-pubkey':
    ensure => present,
  }

  # 1.2.2 Verify that gpgcheck is Globally Activated (Scored)
  augeas { 'cis_1_2_2':
    context => '/files/etc/yum.conf',
    changes => 'set main/gpgcheck 1',
  }

  # 1.2.3 Obtain Software Package Updates with yum (Not Scored)
  # [Updates are installed during installation. See kickstart script.]

  # 1.2.4 Verify Package Integrity Using RPM (Not Scored)
  # [Not implemented]

  # 1.3.1 Install AIDE (Scored)
  package { 'aide':
    ensure => present,
  }

  # 1.3.2 Implement Periodic Execution of File Integrity (Scored)
  # [Not implemented]

  # 1.4.1 Enable SELinux in /etc/grub.conf (Scored)
  augeas { 'cis_1_4_1':
    context => '/files/boot/grub/grub.conf',
    changes => [
      'setm title kernel/selinux 1',
      'setm title kernel/enforcing 1',
    ],
  }

  # 1.4.2 Set the SELinux State (Scored)
  # 1.4.3 Set the SELinux Policy (Scored)
  augeas { 'cis_1_4_2':
    context => '/files/etc/selinux/config',
    changes => [
      'set SELINUX enforcing', # 1.4.2
      'set SELINUXTYPE targeted', # 1.4.3
    ],
  }

  # 1.4.4 Remove SETroubleshoot (Scored)
  # 1.4.5 Remove MCS Translation Service (mcstrans) (Scored)
  package { ['setroubleshoot', 'mcstrans']:
    ensure => absent,
  }

  # 1.4.6 Check for Unconfined Daemons (Scored)
  # [Not implemented]

  # 1.5.1 Set User/Group Owner on /etc/grub.conf (Scored)
  # 1.5.2 Set Permissions on /etc/grub.conf (Scored)
  file { '/boot/grub/grub.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  # 1.5.3 Set Boot Loader Password (Scored)
  # [Set during installation. See kickstart script.]

  # 1.5.4 Require Authentication for Single-User Mode (Scored)
  # 1.5.5 Disable Interactive Boot (Scored)
  augeas { 'cis_1_5_5':
    context => '/files/etc/sysconfig/init',
    changes => [
      'set SINGLE /sbin/sulogin',
      'set PROMPT no',
    ],
  }

  # 1.6.1 Restrict Core Dumps (Scored)
  augeas { 'cis_1_6_1_limits':
    context => '/files/etc/security/limits.conf',
    onlyif  => 'match domain[.=*][./type="hard" and ./item="core" and ./value="0"] size == 0',
    changes => [
      'rm domain[.="*"][./type="hard" and ./item="core"]',
      'set domain[last()+1] *',
      'set domain[last()]/type hard',
      'set domain[last()]/item core',
      'set domain[last()]/value 0',
    ],
  }

  # 1.6.1 Restrict Core Dumps (Scored)
  # 1.6.2 Configure ExecShield (Scored)
  # 1.6.3 Enable Randomized Virtual Memory Region Placement (Scored)
  augeas { 'cis_1_6_1_sysctl':
    context => '/files/etc/sysctl.conf',
    changes => [
      'set fs.suid_dumpable 0', # 1.6.1
      'set kernel.exec-shield 1', # 1.6.2
      'set kernel.randomize_va_space 2', # 1.6.3
    ],
  }

  # 1.7 Use the Latest OS Release (Not Scored)
  # [Using the latest OS]
}
