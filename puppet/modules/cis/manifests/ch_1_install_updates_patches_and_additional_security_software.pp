# == Class: cis::ch_1_install_updates_patches_and_additional_security_software
#
class cis::ch_1_install_updates_patches_and_additional_security_software {

  # 1.1.6 Bind Mount the /var/tmp directory to /tmp (Scored)
  mount { '/var/tmp':
    ensure  => mounted,
    device  => '/tmp',
    fstype  => 'none',
    options => 'bind',
  }

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

  # 1.3.1 Install AIDE (Scored)
  package { 'aide':
    ensure => present,
  }

  # 1.5.5 Disable Interactive Boot (Scored)
  augeas { 'cis_1_5_5':
    context => '/files/etc/sysconfig/init',
    changes => 'set PROMPT no',
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
}
